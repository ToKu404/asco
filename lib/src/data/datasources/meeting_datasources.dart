import 'package:asco/src/data/datasources/profile_datasources.dart';
import 'package:asco/src/data/models/meeting_models/detail_meeting_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MeetingDataSources {
  Future<bool> create({
    required DetailMeetingModel meeting,
    required List<String> listStudentId,
  });
  Future<DetailMeetingModel> single({required String uid});
  Future<List<DetailMeetingModel>> find({
    String? classroomUid,
  });
}

class MeetingDataSourceImpl implements MeetingDataSources {
  final FirebaseFirestore firestore;
  final ProfileDataSource profileDataSource;
  MeetingDataSourceImpl({
    required this.firestore,
    required this.profileDataSource,
  }) {
    collectionReference = firestore.collection('meetings');
  }

  late CollectionReference collectionReference;

  @override
  Future<bool> create({
    required DetailMeetingModel meeting,
    required List<String> listStudentId,
  }) async {
    try {
      final uid = collectionReference.doc().id;

      //create meeting
      final data = DetailMeetingModel(
        assistant1Uid: meeting.assistant1Uid,
        meetingDate: meeting.meetingDate,
        assistant2Uid: meeting.assistant2Uid,
        classUid: meeting.classUid,
        modulPath: meeting.modulPath,
        topic: meeting.topic,
        uid: uid,
        attendances: listStudentId
            .map((e) => AttendanceEntity(
                  attendanceStatus: 3,
                  attendanceTime: null,
                  note: null,
                  pointPlus: null,
                  studentUid: e,
                ))
            .toList(),
        controlCard: {
          for (String k in listStudentId)
            k: const ControlCardEntity(assistance1: null, assistance2: null)
        },
      );
      collectionReference.doc(uid).get().then((value) {
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
  Future<List<DetailMeetingModel>> find({String? classroomUid}) async {
    try {
      Future<QuerySnapshot> snapshot = collectionReference.get();

      if (classroomUid != null) {
        if (classroomUid.isNotEmpty) {
          snapshot = collectionReference
              .where('classroom_uid', isEqualTo: classroomUid)
              .orderBy('meeting_date')
              .get();
        }
      }

      //? all
      return await snapshot.then(
        (value) =>
            value.docs.map((e) => DetailMeetingModel.fromSnapshot(e)).toList(),
      );
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<DetailMeetingModel> single({required String uid}) async {
    try {
      await collectionReference
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          return DetailMeetingModel.fromSnapshot(documentSnapshot);
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
