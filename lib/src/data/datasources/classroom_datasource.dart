import 'package:asco/src/data/models/models.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';

abstract class ClassroomDataSource {
  Future<bool> create({
    required ClassroomModel classroom,
    required PracticumEntity? practicum,
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
    PracticumEntity? practicum,
  }) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        if (!value.exists) {
          collectionReference.doc(uid).set({
            "uid": uid,
            "practicum": firestore.collection('practicums').doc(practicum!.uid),
            "class_code": classroom.classCode,
            "meeting_day": classroom.meetingDay,
            "start_hour": classroom.startHour,
            "end_hour": classroom.endHour,
            "start_minute": classroom.startMinute,
            "end_minute": classroom.endMinute,
          });
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
      return await collectionReference.doc(uid).get().then(
        (documentSnapshot) async {
          if (documentSnapshot.exists) {
            return ClassroomModel.fromSnapshot(
              documentSnapshot,
              ReadHelper.isKeyExist(documentSnapshot, 'students')
                  ? await ReferenceHelper.referenceProfiles(
                      documentSnapshot['students'],
                    )
                  : <ProfileEntity>[],
              documentSnapshot['practicum'] != null
                  ? PracticumModel.fromMap(
                      await ReferenceHelper.referenceSingle<PracticumModel>(
                        documentSnapshot,
                        'practicum',
                      ),
                    ).toEntity()
                  : null,
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
  Future<List<ClassroomModel>> find({String? practicumUid}) async {
    try {
      var snapshot = collectionReference.get();

      if (practicumUid != null) {
        if (practicumUid.isNotEmpty) {
          snapshot = collectionReference
              .where('practicum',
                  isEqualTo:
                      firestore.collection('practicums').doc(practicumUid))
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
              element['practicum'] != null
                  ? PracticumModel.fromMap(
                      await ReferenceHelper.referenceSingle<PracticumModel>(
                        element,
                        'practicum',
                      ),
                    ).toEntity()
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
