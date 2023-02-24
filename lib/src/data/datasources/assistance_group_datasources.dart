import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/assistance_models/assistance_model.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/profile_entities/profile_entity.dart';

abstract class AssistancesGroupDataSources {
  Future<bool> create({
    required AssistanceGroupModel entity,
  });
  Future<AssistanceGroupModel> single(
      {required String uuid, String? assistant});
  Future<List<AssistanceGroupModel>> find({
    required String practicumUid,
  });
  Future<bool> updateStudents({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  });
}

class AttendancesDataSourceImpl implements AssistancesGroupDataSources {
  final FirebaseFirestore firestore;
  AttendancesDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('assistance_groups');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({required AssistanceGroupModel entity}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        if (!value.exists) {
          collectionReference.doc(uid).set(
            {
              "name": entity.name,
              "practicum_uid": entity.practicumUid,
              "uid": uid,
              "assistant":
                  firestore.collection('profiles').doc(entity.assistant!.uid)
            },
          );
        }
        return true;
      }).catchError(
        (error, stackTrace) => throw Exception(),
      );
      return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<AssistanceGroupModel>> find(
      {required String practicumUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot = collectionReference
          .where('practicum_uid', isEqualTo: practicumUid)
          .get();

      //? all

      return await snapshot.then((value) async {
        final List<AssistanceGroupModel> listData = [];
        for (var element in value.docs) {
          print(ReadHelper.isKeyExist(element, 'assistant'));

          listData.add(
            AssistanceGroupModel.fromSnapshot(
                element,
                ReadHelper.isKeyExist(element, 'students')
                    ? await ReferenceHelper.referenceProfiles(
                        element['students'])
                    : [],
                ReadHelper.isKeyExist(element, 'assistant')
                    ? ProfileModel.fromMap(
                        await ReferenceHelper.referenceSingle<ProfileEntity>(
                            element['assistant']))
                    : null),
          );
        }
        return listData;
      });
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<AssistanceGroupModel> single(
      {required String uuid, String? assistant}) async {
    try {
      await collectionReference
          .doc(uuid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          return AssistanceGroupModel.fromSnapshot(
              documentSnapshot,
              ReadHelper.isKeyExist(documentSnapshot, 'students')
                  ? await ReferenceHelper.referenceProfiles(
                      documentSnapshot['students'])
                  : [],
              documentSnapshot['assistant'] != null
                  ? ProfileModel.fromMap(
                      await ReferenceHelper.referenceSingle<ProfileEntity>(
                          documentSnapshot['assistant']))
                  : null);
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
  Future<bool> updateStudents({
    required String assistantGroupUid,
    required List<ProfileEntity> students,
  }) async {
    try {
      collectionReference
          .doc(assistantGroupUid)
          .update({
            "students": students
                .map(
                  (e) => firestore.collection('profiles').doc(e.uid),
                )
                .toList()
          })
          .then((value) => true)
          .catchError((e) => false);

      return false;
    } catch (e) {
      throw Exception();
    }
  }
}
