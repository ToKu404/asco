import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:asco/core/services/preference_service.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/models.dart';
import 'package:asco/src/domain/entities/entities.dart';

abstract class ProfileDataSource {
  Future<bool> create({required DetailProfileModel userProfileModel});

  Future<bool> update({required DetailProfileModel userProfileModel});

  Future<bool> updateMultiplePracticums({
    required Map<String, Map<String, UserPracticumHelper>> data,
  });

  Future<bool> remove({required String uid});

  Future<DetailProfileModel> self();

  Future<DetailProfileModel> single({required String uid});

  Future<List<DetailProfileModel>> multiple({required List<String> multipleId});

  Future<List<DetailProfileModel>> find({
    String? query,
    int? roleId,
    String? practicumUid,
  });

  Future<String> uploadProfilePicture(
    String path,
    String uid,
    String filename,
  );

  Future<void> deleteProfilePicture(
    String uid,
    String filename,
  );
}

class ProfileDataSourceImpl implements ProfileDataSource {
  late CollectionReference collectionReference;
  late Reference storageReference;

  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final AuthPreferenceHelper pref;

  ProfileDataSourceImpl({
    required this.firestore,
    required this.storage,
    required this.pref,
  }) {
    collectionReference = firestore.collection('profiles');
    storageReference = storage.ref('profiles');
  }

  @override
  Future<bool> create({required DetailProfileModel userProfileModel}) async {
    try {
      final snapshot = await collectionReference
          .where('username', isEqualTo: userProfileModel.username)
          .get();

      if (snapshot.docs.isNotEmpty) return false;

      final id = collectionReference.doc().id;

      collectionReference.doc(id).get().then((value) {
        final data = DetailProfileModel(
          uid: id,
          username: userProfileModel.username,
          fullName: userProfileModel.fullName,
          nickName: userProfileModel.nickName,
          gender: userProfileModel.gender,
          classOf: userProfileModel.classOf,
          github: userProfileModel.github,
          instagram: userProfileModel.instagram,
          profilePhoto: userProfileModel.profilePhoto,
          userRole: userProfileModel.userRole,
          userPracticums: const {},
        );
        if (userProfileModel.userRole?.id == 1) {
          firestore.collection('scores').doc(id).set(
                ScoreModel(
                  studentId: id,
                  assistanceScore: 0,
                  examScore: 0,
                  midScore: 0,
                  predicate: 'E',
                  quizScore: 0,
                  recapScore: 0,
                ).toDocument(),
              );
        }

        if (!value.exists) {
          collectionReference.doc(id).set(data.toDocument());
        }

        return true;
      }).catchError((e) => throw FirestoreException(e.toString()));

      return false;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> update({required DetailProfileModel userProfileModel}) async {
    try {
      final updateHelper = UpdateHelper();

      updateHelper.onUpdate('username', userProfileModel.username);
      updateHelper.onUpdate('full_name', userProfileModel.fullName);
      updateHelper.onUpdate('nick_name', userProfileModel.nickName);
      updateHelper.onUpdate('gender', userProfileModel.gender);
      updateHelper.onUpdate('class_of', userProfileModel.classOf);
      updateHelper.onUpdate('github', userProfileModel.github);
      updateHelper.onUpdate('instagram', userProfileModel.instagram);
      updateHelper.onUpdate('profile_photo', userProfileModel.profilePhoto);

      return await collectionReference
          .doc(userProfileModel.uid)
          .update(updateHelper.map)
          .then((_) => true)
          .catchError((_) => false);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> updateMultiplePracticums({
    required Map<String, Map<String, UserPracticumHelper>> data,
  }) async {
    try {
      for (var userUid in data.keys) {
        final map = {
          for (var userPracticumUid in data[userUid]!.keys)
            userPracticumUid: {
              if (data[userUid]![userPracticumUid]!.classroomUid != null)
                'classroom': firestore
                    .collection('classrooms')
                    .doc(data[userUid]![userPracticumUid]!.classroomUid),
              if (data[userUid]![userPracticumUid]!.groupUid != null)
                'group': firestore
                    .collection('assistance_groups')
                    .doc(data[userUid]![userPracticumUid]!.groupUid),
            }
        };

        await collectionReference.doc(userUid).update({'user_practicums': map});
      }

      return true;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> remove({required String uid}) async {
    try {
      return await collectionReference
          .doc(uid)
          .delete()
          .then((_) => true)
          .catchError((_) => false);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<DetailProfileModel> self() async {
    try {
      final credential = await pref.getUser();

      final snapshot = await collectionReference
          .where('username', isEqualTo: credential!.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final map =
            ReadHelper.isKeyExist(snapshot.docs.first, 'user_practicums')
                ? snapshot.docs.first['user_practicums'] as Map<String, dynamic>
                : null;

        Map<String, UserPracticumEntity>? userPracticums;

        if (map != null) {
          userPracticums = {};
          for (var key in map.keys) {
            final Map<String, dynamic> userMap = {};
            final csMap =
                await ReferenceHelper.referenceSingle<ClassroomEntity>(
                    map[key], 'classroom');
            userMap['classroom'] = map[key]['classroom'] != null
                ? ClassroomModel.fromMap(
                    csMap,
                    PracticumModel.fromMap(
                      await ReferenceHelper.referenceSingle<PracticumEntity>(
                        csMap,
                        'practicum',
                      ),
                    ),
                  )
                : null;
            userMap['group'] = map[key]['group'] != null
                ? AssistanceGroupModel.fromMap(
                    await ReferenceHelper.referenceSingle<
                        AssistanceGroupEntity>(map[key], 'group'),
                  )
                : null;
            userPracticums[key] =
                UserPracticumModel.fromMap(userMap).toEntity();
          }
        }

        return DetailProfileModel.fromSnapshot(
          snapshot.docs.first,
          userPracticums,
        );
      } else {
        throw FirestoreException('document is empty');
      }
    } catch (e) {
      throw PreferenceException(e.toString());
    }
  }

  @override
  Future<DetailProfileModel> single({required String uid}) async {
    try {
      await collectionReference.doc(uid).get().then((documentSnapshot) async {
        if (documentSnapshot.exists) {
          final map = ReadHelper.isKeyExist(documentSnapshot, 'user_practicums')
              ? documentSnapshot['user_practicums'] as Map<String, dynamic>
              : null;

          Map<String, UserPracticumEntity>? userPracticums;

          if (map != null) {
            userPracticums = {};
            for (var key in map.keys) {
              final Map<String, dynamic> userMap = {};
              final csMap =
                  await ReferenceHelper.referenceSingle<ClassroomEntity>(
                      map[key], 'classroom');
              userMap['classroom'] = map[key]['classroom'] != null
                  ? ClassroomModel.fromMap(
                      csMap,
                      PracticumModel.fromMap(
                        await ReferenceHelper.referenceSingle<PracticumEntity>(
                          csMap,
                          'practicum',
                        ),
                      ),
                    )
                  : null;
              userMap['group'] = map[key]['group'] != null
                  ? AssistanceGroupModel.fromMap(
                      await ReferenceHelper.referenceSingle<
                          AssistanceGroupEntity>(map[key], 'group'),
                    )
                  : null;
              userPracticums[key] =
                  UserPracticumModel.fromMap(userMap).toEntity();
            }
          }

          return DetailProfileModel.fromSnapshot(
            documentSnapshot,
            userPracticums,
          );
        } else {
          throw FirestoreException('document is not exists');
        }
      });

      throw FirestoreException('something wrong happen');
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<DetailProfileModel>> multiple({
    required List<String> multipleId,
  }) async {
    try {
      final snapshot =
          collectionReference.where('uid', whereIn: multipleId).get();

      return await snapshot.then((value) async {
        final listData = <DetailProfileModel>[];

        for (var element in value.docs) {
          final map = ReadHelper.isKeyExist(element, 'user_practicums')
              ? element['user_practicums'] as Map<String, dynamic>
              : null;

          Map<String, UserPracticumEntity>? userPracticums;

          if (map != null) {
            userPracticums = {};
            for (var key in map.keys) {
              final Map<String, dynamic> userMap = {};
              final csMap =
                  await ReferenceHelper.referenceSingle<ClassroomEntity>(
                      map[key], 'classroom');
              userMap['classroom'] = map[key]['classroom'] != null
                  ? ClassroomModel.fromMap(
                      csMap,
                      PracticumModel.fromMap(
                        await ReferenceHelper.referenceSingle<PracticumEntity>(
                          csMap,
                          'practicum',
                        ),
                      ),
                    )
                  : null;
              userMap['group'] = map[key]['group'] != null
                  ? AssistanceGroupModel.fromMap(
                      await ReferenceHelper.referenceSingle<
                          AssistanceGroupEntity>(map[key], 'group'),
                    )
                  : null;
              userPracticums[key] =
                  UserPracticumModel.fromMap(userMap).toEntity();
            }
          }

          listData.add(DetailProfileModel.fromSnapshot(
            element,
            userPracticums,
          ));
        }

        return listData;
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<DetailProfileModel>> find({
    String? query,
    int? roleId,
    String? practicumUid,
  }) async {
    try {
      var snapshot = collectionReference.get();

      if (roleId != null) {
        snapshot =
            collectionReference.where('role.id', isEqualTo: roleId).get();
      }

      if (practicumUid != null) {
        snapshot = collectionReference
            .where('user_practicums.$practicumUid', isNull: false)
            .get();
      }

      return await snapshot.then((value) async {
        final listData = <DetailProfileModel>[];

        for (var element in value.docs) {
          final map = ReadHelper.isKeyExist(element, 'user_practicums')
              ? element['user_practicums'] as Map<String, dynamic>
              : null;

          Map<String, UserPracticumEntity>? userPracticums;

          if (map != null) {
            userPracticums = {};
            for (var key in map.keys) {
              final Map<String, dynamic> userMap = {};
              final csMap =
                  await ReferenceHelper.referenceSingle<ClassroomEntity>(
                      map[key], 'classroom');

              userMap['group'] = map[key]['group'] != null
                  ? AssistanceGroupModel.fromMap(
                      await ReferenceHelper.referenceSingle<
                          AssistanceGroupEntity>(map[key], 'group'),
                    )
                  : null;

              userMap['classroom'] = map[key]['classroom'] != null
                  ? ClassroomModel.fromMap(
                      csMap,
                      PracticumModel.fromMap(
                        await ReferenceHelper.referenceSingle<PracticumEntity>(
                          csMap,
                          'practicum',
                        ),
                      ),
                    )
                  : null;

              userPracticums[key] =
                  UserPracticumModel.fromMap(userMap).toEntity();
            }
          }
          listData.add(DetailProfileModel.fromSnapshot(
            element,
            userPracticums,
          ));
        }

        return listData;
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> uploadProfilePicture(
    String path,
    String uid,
    String filename,
  ) async {
    final file = File(path);

    try {
      final uploadTask =
          await storageReference.child('$uid/$filename').putFile(file);

      return uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<void> deleteProfilePicture(
    String uid,
    String filename,
  ) async {
    try {
      await storageReference.child('$uid/$filename.jpg').delete();
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
