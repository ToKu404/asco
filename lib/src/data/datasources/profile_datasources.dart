import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/assistance_models/assistance_model.dart';
import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
import 'package:asco/src/data/models/profile_models/detail_profile_model.dart';
import 'package:asco/src/data/models/profile_models/user_practicum_model.dart';
import 'package:asco/src/data/services/preferences_services.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileDataSource {
  Future<bool> create({required DetailProfileModel userProfileModel});
  Future<DetailProfileModel> single({required String uid});
  Future<DetailProfileModel> me();
  Future<List<DetailProfileModel>> multiple({
    required List<String> multipleId,
  });
  Future<bool> update({required DetailProfileModel userProfileModel});
  Future<bool> remove({required String uid});
  Future<List<DetailProfileModel>> find(
      {String? query, int? byRole, String? practicumUid});
  Future<bool> multiplePracticumUpdate(
      {required Map<String, Map<String, UserPracticumHelper>> data});

  // Future<List<DetailProfileModel>> getProfileByClassroom({
  //   required ClassroomEntity classroomEntity,
  // });
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore firestore;
  final AuthPreferenceHelper pref;

  ProfileDataSourceImpl({required this.firestore, required this.pref}) {
    collectionReference = firestore.collection('profiles');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required DetailProfileModel userProfileModel}) async {
    try {
      QuerySnapshot snapshot = await collectionReference
          .where("username", isEqualTo: userProfileModel.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return false;
      } else {
        final id = collectionReference.doc().id;

        collectionReference.doc(id).get().then((value) {
          final data = DetailProfileModel(
            uid: id,
            classOf: userProfileModel.classOf,
            fullName: userProfileModel.fullName,
            gender: userProfileModel.gender,
            github: userProfileModel.github,
            instagram: userProfileModel.instagram,
            nickName: userProfileModel.nickName,
            profilePhoto: userProfileModel.profilePhoto,
            username: userProfileModel.username,
            userRole: userProfileModel.userRole,
            userPracticums: const {},
          );
          if (!value.exists) {
            collectionReference.doc(id).set(
                  data.toDocument(),
                );
          }
          return true;
        }).catchError(
          (error, stackTrace) => throw Exception(),
        );
        return false;
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<DetailProfileModel>> find(
      {String? query, int? byRole, String? practicumUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();
      // Todo : Finish Search
      if (practicumUid != null) {
        snapshot = collectionReference
            .where('user_practicums.$practicumUid', isNull: false)
            .get();
      }
      //? by Role
      if (byRole != null) {
        snapshot =
            collectionReference.where('role.id', isEqualTo: byRole).get();
      }

      //? all
      return await snapshot.then((value) async {
        final List<DetailProfileModel> listData = [];
        for (var element in value.docs) {
          final map = ReadHelper.isKeyExist(element, 'user_practicums')
              ? element['user_practicums'] as Map<String, dynamic>
              : null;
          Map<String, UserPracticumEntity>? userPrac;
          if (map != null) {
            userPrac = {
              for (String k in map.keys)
                k: UserPracticumModel.fromMap({
                  'classroom': map[k]['classroom'] != null
                      ? ClassroomModel.fromMap(
                          await ReferenceHelper.referenceSingle<
                              ClassroomEntity>(map[k]['classroom']))
                      : null,
                  'group': map[k]['group'] != null
                      ? AssistanceGroupModel.fromMap(
                          await ReferenceHelper.referenceSingle<
                              AssistanceGroupEntity>(map[k]['group']))
                      : null,
                }).toEntity(),
            };
          }
          listData.add(
            DetailProfileModel.fromSnapshot(
              element,
              userPrac,
            ),
          );
        }
        return listData;
      });
    } catch (e) {
      print('object');
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<List<DetailProfileModel>> multiple({
    required List<String> multipleId,
  }) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot = collectionReference
          .where(
            'uid',
            whereIn: multipleId,
          )
          .get();

      return await snapshot.then((value) async {
        final List<DetailProfileModel> listData = [];
        for (var element in value.docs) {
          final map = ReadHelper.isKeyExist(element, 'user_practicums')
              ? element['user_practicums'] as Map<String, dynamic>
              : null;
          Map<String, UserPracticumEntity>? userPrac;
          if (map != null) {
            userPrac = {
              for (String k in map.keys)
                k: UserPracticumModel.fromMap({
                  'classroom': map[k]['classroom'] != null
                      ? ClassroomModel.fromMap(
                          await ReferenceHelper.referenceSingle<
                              ClassroomEntity>(map[k]['classroom']))
                      : null,
                  'group': map[k]['group'] != null
                      ? AssistanceGroupModel.fromMap(
                          await ReferenceHelper.referenceSingle<
                              AssistanceGroupEntity>(map[k]['group']))
                      : null,
                }).toEntity(),
            };
          }
          listData.add(
            DetailProfileModel.fromSnapshot(
              element,
              userPrac,
            ),
          );
        }
        return listData;
      });
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<bool> remove({required String uid}) async {
    try {
      return await collectionReference
          .doc(uid)
          .delete()
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<DetailProfileModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          final map = ReadHelper.isKeyExist(documentSnapshot, 'user_practicums')
              ? documentSnapshot['user_practicums'] as Map<String, dynamic>
              : null;
          Map<String, UserPracticumEntity>? userPrac;
          if (map != null) {
            userPrac = {
              for (String k in map.keys)
                k: UserPracticumModel.fromMap({
                  'classroom': map[k]['classroom'] != null
                      ? ClassroomModel.fromMap(
                          await ReferenceHelper.referenceSingle<
                              ClassroomEntity>(map[k]['classroom']))
                      : null,
                  'group': map[k]['group'] != null
                      ? AssistanceGroupModel.fromMap(
                          await ReferenceHelper.referenceSingle<
                              AssistanceGroupEntity>(map[k]['group']))
                      : null,
                }).toEntity(),
            };
          }
          return DetailProfileModel.fromSnapshot(documentSnapshot, userPrac);
        } else {
          throw Exception();
        }
      });
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> update({required DetailProfileModel userProfileModel}) async {
    try {
      UpdateHelper updateHelper = UpdateHelper();

      updateHelper.onUpdate('class_of', userProfileModel.classOf);
      updateHelper.onUpdate('full_name', userProfileModel.fullName);
      updateHelper.onUpdate('gender', userProfileModel.gender);
      updateHelper.onUpdate('github', userProfileModel.github);
      updateHelper.onUpdate('username', userProfileModel.username);
      updateHelper.onUpdate('instagram', userProfileModel.instagram);
      updateHelper.onUpdate('nick_name', userProfileModel.nickName);
      updateHelper.onUpdate('profile_photo', userProfileModel.profilePhoto);

      return await collectionReference
          .doc(userProfileModel.uid)
          .update(updateHelper.map)
          .then((value) => true)
          .catchError((e) => false);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<DetailProfileModel> me() async {
    try {
      final credential = await pref.getUser();

      QuerySnapshot snapshot = await collectionReference
          .where("username", isEqualTo: credential!.username)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final map =
            ReadHelper.isKeyExist(snapshot.docs.first, 'user_practicums')
                ? snapshot.docs.first['user_practicums'] as Map<String, dynamic>
                : null;
        Map<String, UserPracticumEntity>? userPrac;
        if (map != null) {
          userPrac = {
            for (String k in map.keys)
              k: UserPracticumModel.fromMap({
                'classroom': map[k]['classroom'] != null
                    ? ClassroomModel.fromMap(
                        await ReferenceHelper.referenceSingle<ClassroomEntity>(
                            map[k]['classroom']))
                    : null,
                'group': map[k]['group'] != null
                    ? AssistanceGroupModel.fromMap(
                        await ReferenceHelper.referenceSingle<
                            AssistanceGroupEntity>(map[k]['group']))
                    : null,
              }).toEntity(),
          };
        }
        return DetailProfileModel.fromSnapshot(snapshot.docs.first, userPrac);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> multiplePracticumUpdate(
      {required Map<String, Map<String, UserPracticumHelper>> data}) async {
    try {
      for (String k in data.keys) {
        final map = {
          for (String k2 in data[k]!.keys)
            k2: {
              'group': firestore
                  .collection('assistance_groups')
                  .doc(data[k]![k2]!.groupUid),
              'classroom': firestore
                  .collection('classrooms')
                  .doc(data[k]![k2]!.classroomUid)
            }
        };
        await collectionReference.doc(k).update(
          {
            'user_practicums': map,
          },
        );
      }
      return true;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}
