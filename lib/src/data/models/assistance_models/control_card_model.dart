import 'package:asco/src/data/models/assistance_models/assistance_attendance_model.dart';
import 'package:asco/src/data/models/meeting_models/meeting_model.dart';
import 'package:asco/src/data/models/profile_models/profile_model.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlCardModel extends ControlCardEntity {
  const ControlCardModel({
    required super.assistance1,
    required super.assistance2,
    required super.meeting,
    required super.studentId,
    required super.uid,
  });

  Map<String, dynamic> toDocument() {
    return {
      if (assistance1 != null)
        'assistance1':
            AssistanceAttendanceModel.fromEntity(assistance1!).toDocument(),
      if (assistance2 != null)
        'assistance2':
            AssistanceAttendanceModel.fromEntity(assistance2!).toDocument(),
      if (meeting != null)
        'meeting': MeetingModel.fromEntity(meeting!).toDocument(),
      'student_id': studentId,
      'uid': uid,
    };
  }

  ControlCardEntity toEntity() {
    return ControlCardEntity(
      assistance1: assistance1,
      assistance2: assistance2,
      meeting: meeting,
      studentId: studentId,
      uid: uid,
    );
  }

  factory ControlCardModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return ControlCardModel(
      assistance1: documentSnapshot['assistance1'],
      assistance2: documentSnapshot['assistance2'],
      meeting: documentSnapshot['meeting'],
      studentId: documentSnapshot['student_id'],
      uid: documentSnapshot['uid'],
    );
  }

  factory ControlCardModel.fromEntity(ControlCardEntity entity) {
    return ControlCardModel(
      assistance1: entity.assistance1,
      assistance2: entity.assistance2,
      meeting: entity.meeting,
      studentId: entity.studentId,
      uid: entity.uid,
    );
  }
}
