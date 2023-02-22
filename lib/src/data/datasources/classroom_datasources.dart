import 'package:asco/src/data/models/classroom_models/classroom_model.dart';
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

      // await collectionReference
      //     .add(
      //       ClassroomModel(
      //         startHour: classroom.startHour,
      //         endHour: classroom.endHour,
      //         startMinute: classroom.startMinute,
      //         endMinute: classroom.endMinute,
      //         meetingDay: classroom.meetingDay,
      //         practicumUid: practicumUid,
      //         uid: uid,
      //         classCode: classroom.classCode,
      //         courseName: classroom.courseName,
      //       ).toDocument(),
      //     )
      //     .then((value) => true)
      //     .catchError((error) => false);
      // return false;
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
      return await snapshot.then(
        (value) => value.docs
            .map(
              (e) => ClassroomModel.fromSnapshot(e),
            )
            .toList(),
      );
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<ClassroomModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return ClassroomModel.fromSnapshot(documentSnapshot);
        } else {
          throw Exception();
        }
      });
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
