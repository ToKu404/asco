import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';

class AssistanceAttendanceModel extends AssistanceAttendanceEntity {
  const AssistanceAttendanceModel({
    required super.assistanceDateTime,
    required super.note,
    required super.status,
  });

  Map<String, dynamic> toDocument() {
    return {
      "assistance_datetime": assistanceDateTime,
      "note": note,
      "status": status,
    };
  }

  AssistanceAttendanceEntity toEntity() {
    return AssistanceAttendanceEntity(
      assistanceDateTime: assistanceDateTime,
      note: note,
      status: status,
    );
  }

  factory AssistanceAttendanceModel.fromMap(
      Map<String, dynamic> documentSnapshot) {
    return AssistanceAttendanceModel(
      assistanceDateTime: documentSnapshot['assistance_datetime'],
      note: documentSnapshot['note'],
      status: documentSnapshot['status'],
    );
  }

  factory AssistanceAttendanceModel.fromEntity(
      AssistanceAttendanceEntity entity) {
    return AssistanceAttendanceModel(
      assistanceDateTime: entity.assistanceDateTime,
      note: entity.note,
      status: entity.status,
    );
  }
}
