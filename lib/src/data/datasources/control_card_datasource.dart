import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/helpers/helpers.dart';
import 'package:asco/src/data/models/assistance_models/control_card_model.dart';
import 'package:asco/src/data/models/assistance_models/control_card_result_model.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';

abstract class ControlCardDataSource {
  Future<bool> initForStudent({
    required List<String>? addedStudentId,
    required List<String>? removeStudentId,
    required String practicumUid,
  });

  Future<ControlCardModel> single({required String uid});

  Future<ControlCardResultModel> find({String? studentId});

  Future<List<ControlCardResultEntity>> multiple(
      {required List<String> multipleId});
}

class ControlCardDataSourceImpl implements ControlCardDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;

  ControlCardDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('control_cards');
  }

  @override
  Future<bool> initForStudent({
    List<String>? addedStudentId,
    List<String>? removeStudentId,
    String? practicumUid,
  }) async {
    try {
      var id = 0;

      for (var sId in addedStudentId!) {
        final snapshot =
            await collectionReference.where('student_id', isEqualTo: sId).get();

        if (snapshot.docs.isEmpty) {
          final uid = collectionReference.doc().id;

          collectionReference.doc(uid).get().then((value) {
            if (!value.exists) {
              collectionReference.doc(uid).set({
                "uid": uid,
                "student_id": sId,
                "student": firestore.collection('profiles').doc(sId),
                "practicum_uid": practicumUid,
                "data": List.generate(
                  16,
                  (index) => ControlCardModel(
                    assistance1: null,
                    assistance2: null,
                    meetingNumber: id,
                  ).toDocument(),
                ),
              });
            }
          }).catchError((e) => throw FirestoreException(e.toString()));
        }

        id++;
      }

      return true;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<ControlCardModel> single({required String uid}) async {
    try {
      return await collectionReference.doc(uid).get().then(
        (documentSnapshot) {
          if (documentSnapshot.exists) {
            return ControlCardModel.fromSnapshot(documentSnapshot);
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
  Future<ControlCardResultModel> find({String? studentId}) async {
    try {
      final snapshot =
          collectionReference.where('student_id', isEqualTo: studentId).get();

      return await snapshot.then((value) async {
        final data = value.docs.first;

        return ControlCardResultModel.fromSnapshot(
          data,
          ReadHelper.isKeyExist(data, 'data')
              ? await ReferenceHelper.referenceCC(data['data'])
              : <ControlCardEntity>[],
          data['student'] != null
              ? ProfileModel.fromMap(
                  await ReferenceHelper.referenceSingle<ProfileModel>(
                    data,
                    'student',
                  ),
                ).toEntity()
              : null,
        );
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<ControlCardResultEntity>> multiple(
      {required List<String> multipleId}) async {
    try {
      final snapshot =
          collectionReference.where('student_id', whereIn: multipleId).get();
      return await snapshot.then((value) async {
        final listData = <ControlCardResultEntity>[];
        for (var data in value.docs) {
          final studentData = ControlCardResultModel.fromSnapshot(
            data,
            ReadHelper.isKeyExist(data, 'data')
                ? await ReferenceHelper.referenceCC(data['data'])
                : <ControlCardEntity>[],
            data['student'] != null
                ? ProfileModel.fromMap(
                    await ReferenceHelper.referenceSingle<ProfileModel>(
                      data,
                      'student',
                    ),
                  ).toEntity()
                : null,
          );
          listData.add(studentData);
        }
        return listData;
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
