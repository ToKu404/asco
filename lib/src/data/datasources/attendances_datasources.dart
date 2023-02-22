import 'package:asco/src/data/models/attendance_models/attendance_model.dart';
import 'package:asco/src/data/models/attendance_models/attendance_result_model.dart';
import 'package:asco/src/data/models/meeting_models/meeting_model.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AttendancesDataSources {
  Future<bool> create({
    required MeetingModel meeting,
    required String classroomUid,
    required List<DetailProfileEntity> students,
  });
  Future<bool> update({
    required String uid,
    required AttendanceModel attendance,
    required AttendanceModel oldAttendance,
  });
  Future<AttendanceResultModel?> single(
      {required String meetingUid, required String classroomUid});
  Future<List<AttendanceResultModel>> find({
    required String classroomUid,
  });
}

class AttendancesDataSourceImpl implements AttendancesDataSources {
  final FirebaseFirestore firestore;
  AttendancesDataSourceImpl({required this.firestore}) {
    collectionReference = firestore.collection('meeting_attendances');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> update(
      {required String uid,
      required AttendanceModel attendance,
      required AttendanceModel oldAttendance}) async {
    try {
      collectionReference.doc(uid).update({
        "attendances": FieldValue.arrayRemove([oldAttendance])
      }).then((value) {
        collectionReference
            .doc(uid)
            .update({
              "attendances": FieldValue.arrayUnion([attendance])
            })
            .then((value) => true)
            .catchError((e) => false);
      });
      return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> create({
    required MeetingModel meeting,
    required String classroomUid,
    required List<DetailProfileEntity> students,
  }) async {
    try {
      final uid = collectionReference.doc().id;
      collectionReference.doc(uid).get().then((value) {
        final data = AttendanceResultModel(
          attendances: students
              .map(
                (e) => AttendanceModel(
                  //! uuid attendance == student uid
                  attendanceStatus: 3,
                  attendanceTime: null,
                  note: null,
                  pointPlus: null,
                  studentUid: e.uid,
                ),
              )
              .toList(),
          meeting: meeting,
          uid: uid,
          classroomUid: classroomUid,
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
      //       AttendanceResultModel(
      //         attendances: students
      //             .map(
      //               (e) => AttendanceModel(
      //                 uuid: e.uid,
      //                 attendanceStatus: 3,
      //                 attendanceTime: null,
      //                 note: null,
      //                 pointPlus: null,
      //                 student: ProfileEntity(
      //                   fullName: e.fullName,
      //                   profilePhoto: e.profilePhoto,
      //                   uid: e.uid,
      //                   userRole: e.userRole,
      //                   username: e.username,
      //                 ),
      //               ),
      //             )
      //             .toList(),
      //         meeting: meeting,
      //         uid: uid,
      //         classroomUid: classroomUid,
      //       ),
      //     )
      //     .then((value) => true)
      //     .catchError((error) => false);
      // return false;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<AttendanceResultModel>> find(
      {required String classroomUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot = collectionReference
          .where('classroom_uid', isEqualTo: classroomUid)
          .get();

      //? all
      return await snapshot.then(
        (value) => value.docs
            .map(
              (e) => AttendanceResultModel.fromSnapshot(e),
            )
            .toList(),
      );
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  @override
  Future<AttendanceResultModel?> single(
      {required String meetingUid, required String classroomUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      snapshot = collectionReference
          .where('classroom_uid', isEqualTo: classroomUid)
          .where('meeting.uid', isEqualTo: meetingUid)
          .get();

      return await snapshot.then((value) {
        if (value.docs.isEmpty) {
          return null;
        }
        return AttendanceResultModel.fromSnapshot(
          value.docs.first,
        );
      });
    } catch (e) {
      throw Exception();
    }
  }
}
