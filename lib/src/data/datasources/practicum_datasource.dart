import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/practicum_models/practicum_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

abstract class PracticumDataSource {
  Future<bool> create({required PracticumModel practicum});

  Future<PracticumModel> single({required String uid});

  Future<List<PracticumModel>> find({String? query});

  Future<bool> updateAssistants({
    required String practicumUid,
    required List<ProfileEntity> assistants,
  });
}

class PracticumDataSourceImpl implements PracticumDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;

  PracticumDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('practicums');
  }

  @override
  Future<bool> create({required PracticumModel practicum}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = PracticumModel(
          uid: uid,
          badgePath: practicum.badgePath,
          course: practicum.course,
          courseContractPath: practicum.courseContractPath,
        );

        if (!value.exists) {
          collectionReference.doc(uid).set(data.toDocument());
        }

        return true;
      }).catchError((e) => throw FirestoreException(e.toString()));

      return false;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<PracticumModel> single({required String uid}) async {
    try {
      return await collectionReference.doc(uid).get().then(
        (documentSnapshot) async {
          if (documentSnapshot.exists) {
            return PracticumModel.fromSnapshot(
              documentSnapshot,
              ReadHelper.isKeyExist(documentSnapshot, 'list_assistant')
                  ? await ReferenceHelper.referenceProfiles(
                      documentSnapshot['list_assistant'],
                    )
                  : <ProfileEntity>[],
            );
          } else {
            throw FirestoreException('document is not exists.');
          }
        },
      );
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<PracticumModel>> find({String? query}) async {
    try {
      var snapshot = collectionReference.get();

      if (query != null) {
        if (query.isNotEmpty) {
          snapshot =
              collectionReference.where('course', isEqualTo: query).get();
        }
      }

      return await snapshot.then((value) async {
        final listData = <PracticumModel>[];

        for (var element in value.docs) {
          listData.add(
            PracticumModel.fromSnapshot(
              element,
              ReadHelper.isKeyExist(element, 'list_assistant')
                  ? await ReferenceHelper.referenceProfiles(
                      element['list_assistant'],
                    )
                  : <ProfileEntity>[],
            ),
          );
        }

        return listData;
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> updateAssistants({
    required String practicumUid,
    required List<ProfileEntity> assistants,
  }) async {
    try {
      collectionReference
          .doc(practicumUid)
          .update({
            "list_assistant": assistants
                .map((e) => firestore.collection('profiles').doc(e.uid))
                .toList()
          })
          .then((_) => true)
          .catchError((_) => false);

      return false;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
