import 'package:asco/src/domain/entities/assistance_entities/assistance_attendance_entity.dart';

class AssistanceAttendanceModel extends AssistanceAttendanceEntity {
  const AssistanceAttendanceModel({
    super.assistanceDateTime,
    super.status,
    super.note,
  });

  Map<String, dynamic> toDocument() {
    return {
      "assistance_datetime": assistanceDateTime,
      "status": status,
      "note": note,
    };
  }

  AssistanceAttendanceEntity toEntity() {
    return AssistanceAttendanceEntity(
      assistanceDateTime: assistanceDateTime,
      status: status,
      note: note,
    );
  }

  factory AssistanceAttendanceModel.fromMap(
      Map<String, dynamic> documentSnapshot) {
    return AssistanceAttendanceModel(
      assistanceDateTime: documentSnapshot['assistance_datetime'].toDate(),
      status: documentSnapshot['status'],
      note: documentSnapshot['note'],
    );
  }

  factory AssistanceAttendanceModel.fromEntity(
      AssistanceAttendanceEntity entity) {
    return AssistanceAttendanceModel(
      assistanceDateTime: entity.assistanceDateTime,
      status: entity.status,
      note: entity.note,
    );
  }
}
