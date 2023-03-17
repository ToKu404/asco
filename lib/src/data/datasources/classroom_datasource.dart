import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

abstract class ClassroomDataSource {
  Future<bool> create({
    required ClassroomModel classroom,
    required String practicumUid,
  });

  Future<ClassroomModel> single({required String uid});

  Future<List<ClassroomModel>> find({String? practicumUid});

  Future<bool> updateStudents({
    required String classroomUid,
    required List<ProfileEntity> students,
  });
}

class ClassroomDataSourceImpl implements ClassroomDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;

  ClassroomDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('classrooms');
  }

  @override
  Future<bool> create({
    required ClassroomModel classroom,
    required String practicumUid,
  }) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = ClassroomModel(
          uid: uid,
          practicumUid: practicumUid,
          classCode: classroom.classCode,
          courseName: classroom.courseName,
          meetingDay: classroom.meetingDay,
          startHour: classroom.startHour,
          endHour: classroom.endHour,
          startMinute: classroom.startMinute,
          endMinute: classroom.endMinute,
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
  Future<ClassroomModel> single({required String uid}) async {
    try {
      final model = await collectionReference.doc(uid).get().then(
        (documentSnapshot) async {
          if (documentSnapshot.exists) {
            return ClassroomModel.fromSnapshot(
              documentSnapshot,
              ReadHelper.isKeyExist(documentSnapshot, 'students')
                  ? await ReferenceHelper.referenceProfiles(
                      documentSnapshot['students'],
                    )
                  : <ProfileEntity>[],
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
  Future<List<ClassroomModel>> find({String? practicumUid}) async {
    try {
      var snapshot = collectionReference.get();

      if (practicumUid != null) {
        if (practicumUid.isNotEmpty) {
          snapshot = collectionReference
              .where('practicum_uid', isEqualTo: practicumUid)
              .get();
        }
      }

      return await snapshot.then((value) async {
        final listData = <ClassroomModel>[];

        for (var element in value.docs) {
          listData.add(
            ClassroomModel.fromSnapshot(
              element,
              ReadHelper.isKeyExist(element, 'students')
                  ? await ReferenceHelper.referenceProfiles(element['students'])
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
  Future<bool> updateStudents({
    required String classroomUid,
    required List<ProfileEntity> students,
  }) async {
    try {
      collectionReference
          .doc(classroomUid)
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
