import 'package:asco/src/data/datasources/helpers/ds_helper.dart';
import 'package:asco/src/data/models/assistance_models/control_card_model.dart';
import 'package:asco/src/data/models/attendance_models/attendance_model.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailMeetingModel extends DetailMeetingEntity {
  const DetailMeetingModel({
    required super.assistant1Uid,
    required super.meetingDate,
    required super.assistant2Uid,
    required super.classUid,
    required super.modulPath,
    required super.topic,
    required super.uid,
    required super.attendances,
    required super.controlCard,
  });

  Map<String, dynamic> toDocument() {
    return {
      'assistant1_uid': assistant1Uid,
      'meeting_date': meetingDate,
      'assistant2_uid': assistant2Uid,
      'classroom_uid': classUid,
      'modul_path': modulPath,
      'topic': topic,
      'uid': uid,
      "attendances": (attendances != null)
          ? attendances!
              .map((e) => AttendanceModel.fromEntity(e).toDocument())
              .toList()
          : [],
      "control_cards": (controlCard != null)
          ? {
              for (var k in controlCard!.keys)
                k: ControlCardModel.fromEntity(controlCard![k]!).toDocument()
            }
          : null,
    };
  }

  DetailMeetingEntity toEntity() {
    return DetailMeetingEntity(
      assistant1Uid: assistant1Uid,
      meetingDate: meetingDate,
      assistant2Uid: assistant2Uid,
      classUid: classUid,
      modulPath: modulPath,
      topic: topic,
      uid: uid,
      attendances: attendances,
    );
  }

  factory DetailMeetingModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DetailMeetingModel(
      assistant1Uid: documentSnapshot['assistant1_uid'],
      meetingDate: documentSnapshot['meeting_date'].toDate(),
      assistant2Uid: documentSnapshot['assistant2_uid'],
      classUid: documentSnapshot['classroom_uid'],
      modulPath: documentSnapshot['modul_path'],
      topic: documentSnapshot['topic'],
      uid: documentSnapshot['uid'],
      attendances: ReadHelper.isKeyExist(documentSnapshot, 'attendances')
          ? List<AttendanceEntity>.from(
              documentSnapshot.get('attendances').map(
                    (e) => AttendanceModel.fromMap(e).toEntity(),
                  ),
            )
          : [],
      controlCard: null,
    );
  }

  factory DetailMeetingModel.fromEntity(DetailMeetingEntity entity) {
    return DetailMeetingModel(
      assistant1Uid: entity.assistant1Uid,
      meetingDate: entity.meetingDate,
      assistant2Uid: entity.assistant2Uid,
      classUid: entity.classUid,
      modulPath: entity.modulPath,
      topic: entity.topic,
      uid: entity.uid,
      attendances: entity.attendances,
      controlCard: entity.controlCard,
    );
  }
}
