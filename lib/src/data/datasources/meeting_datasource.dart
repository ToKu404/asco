import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:asco/core/utils/exception.dart';
import 'package:asco/src/data/datasources/profile_datasource.dart';
import 'package:asco/src/data/models/attendance_models/attendance_model.dart';
import 'package:asco/src/data/models/meeting_models/detail_meeting_model.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

abstract class MeetingDataSource {
  Future<bool> create({
    required DetailMeetingModel meeting,
    required List<String> listStudentId,
  });

  Future<DetailMeetingModel> single({required String uid});

  Future<List<DetailMeetingModel>> find({String? classroomUid});

  Future<bool> updateAttendance({
    required String uid,
    required List<AttendanceModel> listAttendanceModel,
  });
}

class MeetingDataSourceImpl implements MeetingDataSource {
  late CollectionReference collectionReference;

  final FirebaseFirestore firestore;
  final ProfileDataSource profileDataSource;

  MeetingDataSourceImpl({
    required this.firestore,
    required this.profileDataSource,
  }) {
    collectionReference = firestore.collection('meetings');
  }

  @override
  Future<bool> create({
    required DetailMeetingModel meeting,
    required List<String> listStudentId,
  }) async {
    try {
      final uid = collectionReference.doc().id;

      final data = DetailMeetingModel(
        uid: uid,
        classUid: meeting.classUid,
        assistant1Uid: meeting.assistant1Uid,
        assistant2Uid: meeting.assistant2Uid,
        meetingDate: meeting.meetingDate,
        topic: meeting.topic,
        modulPath: meeting.modulPath,
        // meetingNumber: meeting.meetingNumber,
        attendances: listStudentId
            .map(
              (id) => AttendanceEntity(
                studentUid: id,
                attendanceTime: null,
                attendanceStatus: null,
                pointPlus: null,
                note: null,
              ),
            )
            .toList(),
        // controlCard: {
        //   for (String k in listStudentId)
        //     k: const ControlCardEntity(assistance1: null, assistance2: null)
        // },
      );

      collectionReference.doc(uid).get().then((value) {
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
  Future<DetailMeetingModel> single({required String uid}) async {
    try {
      return await collectionReference.doc(uid).get().then(
        (documentSnapshot) {
          if (documentSnapshot.exists) {
            return DetailMeetingModel.fromSnapshot(documentSnapshot);
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
  Future<List<DetailMeetingModel>> find({String? classroomUid}) async {
    try {
      var snapshot = collectionReference.get();

      if (classroomUid != null && classroomUid.isNotEmpty) {
        snapshot = collectionReference
            .where('classroom_uid', isEqualTo: classroomUid)
            .orderBy('meeting_date')
            .get();
      }

      return await snapshot.then((value) {
        return value.docs
            .map((snapshot) => DetailMeetingModel.fromSnapshot(snapshot))
            .toList();
      });
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> updateAttendance({
    required String uid,
    required List<AttendanceModel> listAttendanceModel,
  }) async {
    try {
      return collectionReference
          .doc(uid)
          .update({
            'attendances': listAttendanceModel
                .map((am) => AttendanceModel(
                      studentUid: am.studentUid,
                      attendanceTime: am.attendanceTime,
                      attendanceStatus: am.attendanceStatus,
                      pointPlus: am.pointPlus,
                      note: am.note,
                    ).toDocument())
                .toList()
          })
          .then((value) => true)
          .catchError((error) => false);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
