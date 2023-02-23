import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/datasources/helpers/reference_helper.dart';
import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ClassroomDataSource {
  Future<bool> create({
    required ClassroomModel classroom,
    required String practicumUid,
  });
  Future<ClassroomModel> single({required String uid});
  Future<List<ClassroomModel>> find({
    String? practicumUid,
  });
  Future<bool> updateStudents({
    required String classroomUid,
    required List<ProfileEntity> students,
  });
}

class ClassroomDataSourceImpl implements ClassroomDataSource {
  final FirebaseFirestore firestore;
  ClassroomDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('classrooms');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create(
      {required ClassroomModel classroom, required String practicumUid}) async {
    try {
      final uid = collectionReference.doc().id;

      collectionReference.doc(uid).get().then((value) {
        final data = ClassroomModel(
          startHour: classroom.startHour,
          endHour: classroom.endHour,
          startMinute: classroom.startMinute,
          endMinute: classroom.endMinute,
          meetingDay: classroom.meetingDay,
          practicumUid: practicumUid,
          uid: uid,
          classCode: classroom.classCode,
          courseName: classroom.courseName,
        );
        if (!value.exists) {
          collectionReference.doc(uid).set(
                data.toDocument(),
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
  Future<List<ClassroomModel>> find({String? practicumUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      if (practicumUid != null) {
        if (practicumUid.isNotEmpty) {
          snapshot = collectionReference
              .where('practicum_uid', isEqualTo: practicumUid)
              .get();
        }
      }
      //? all
      return await snapshot.then((value) async {
        final List<ClassroomModel> listData = [];
        for (var element in value.docs) {
          listData.add(
            ClassroomModel.fromSnapshot(
              element,
              ReadHelper.isKeyExist(element, 'students')
                  ? await ReferenceHelper.referenceProfiles(element['students'])
                  : [],
            ),
          );
        }
        return listData;
      });
    } catch (e) {
      print('here');

      throw Exception();
    }
  }

  @override
  Future<ClassroomModel> single({required String uid}) async {
    try {
      return await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          return ClassroomModel.fromSnapshot(
            documentSnapshot,
            ReadHelper.isKeyExist(documentSnapshot, 'students')
                ? await ReferenceHelper.referenceProfiles(
                    documentSnapshot['students'])
                : [],
          );
        } else {
          throw Exception();
        }
      });
    } catch (e) {
      throw Exception();
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
