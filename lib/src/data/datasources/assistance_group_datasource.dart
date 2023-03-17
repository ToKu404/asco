import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/assistance_models/assistance_group_model.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

abstract class AssistanceGroupDataSource {
  Future<bool> create({
    required AssistanceGroupModel assistanceGroup,
  });

  Future<AssistanceGroupModel> single({
    required String uuid,
    String? assistant,
  });

  Future<List<AssistanceGroupModel>> find({
    required String practicumUid,
  });

  Future<bool> updateStudents({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  });
}

class AssistanceGroupDataSourceImpl implements AssistanceGroupDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;

  AssistanceGroupDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('assistance_groups');
  }

  @override
  Future<bool> create({
    required AssistanceGroupModel assistanceGroup,
  }) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        if (!value.exists) {
          collectionReference.doc(uid).set(
            {
              "name": assistanceGroup.name,
              "practicum_uid": assistanceGroup.practicumUid,
              "uid": uid,
              "assistant": firestore
                  .collection('profiles')
                  .doc(assistanceGroup.assistant!.uid)
            },
          );
        }

        return true;
      }).catchError((e) => throw FirestoreException(e.toString()));

      return false;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<AssistanceGroupModel> single({
    required String uuid,
    String? assistant,
  }) async {
    try {
      final model = await collectionReference.doc(uuid).get().then(
        (documentSnapshot) async {
          if (documentSnapshot.exists) {
            return AssistanceGroupModel.fromSnapshot(
              documentSnapshot,
              ReadHelper.isKeyExist(documentSnapshot, 'students')
                  ? await ReferenceHelper.referenceProfiles(
                      documentSnapshot['students'],
                    )
                  : <ProfileEntity>[],
              documentSnapshot['assistant'] != null
                  ? ProfileModel.fromMap(
                      await ReferenceHelper.referenceSingle<ProfileEntity>(
                        documentSnapshot['assistant'],
                      ),
                    )
                  : null,
            );
          } else {
            throw FirestoreException('document is not exists.');
          }
        },
      );

      return model;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<AssistanceGroupModel>> find({
    required String practicumUid,
  }) async {
    try {
      final snapshot = collectionReference
          .where('practicum_uid', isEqualTo: practicumUid)
          .get();

      return await snapshot.then((querySnapshot) async {
        final listData = <AssistanceGroupModel>[];

        for (var element in querySnapshot.docs) {
          listData.add(
            AssistanceGroupModel.fromSnapshot(
              element,
              ReadHelper.isKeyExist(element, 'students')
                  ? await ReferenceHelper.referenceProfiles(element['students'])
                  : <ProfileEntity>[],
              ReadHelper.isKeyExist(element, 'assistant')
                  ? ProfileModel.fromMap(
                      await ReferenceHelper.referenceSingle<ProfileEntity>(
                        element['assistant'],
                      ),
                    )
                  : null,
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
  Future<bool> updateStudents({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  }) async {
    try {
      collectionReference
          .doc(assistantGroupUid)
          .update({
            'students': students
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
