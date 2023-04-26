import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';

class UpdateDataHelper {
  static List<AttendanceEntity> updateAttendance({
    required String studentUid,
    required List<AttendanceEntity> attendanceList,
    required AttendanceEntity updateAttendance,
  }) {
    for (var i = 0; i < attendanceList.length; i++) {
      if (attendanceList[i].studentUid == studentUid) {
        attendanceList[i] = AttendanceEntity(
          attendanceStatus: updateAttendance.attendanceStatus ??
              attendanceList[i].attendanceStatus,
          pointPlus: updateAttendance.pointPlus ?? attendanceList[i].pointPlus,
          note: updateAttendance.note ?? attendanceList[i].note,
          attendanceTime: updateAttendance.attendanceTime ??
              attendanceList[i].attendanceTime,
          uuid: attendanceList[i].uuid,
          quizScore: updateAttendance.quizScore ?? attendanceList[i].quizScore,
          studentUid: attendanceList[i].studentUid,
        );
      }
    }

    return attendanceList;
  }

  static List<ControlCardEntity> updateControlCard({
    bool? isFirstAssistant,
    required int meetingNumber,
    required List<ControlCardEntity> ccEntityList,
    required ControlCardEntity newCC,
  }) {
    for (var i = 0; i < ccEntityList.length; i++) {
      if (meetingNumber == i + 1) {
        ccEntityList[i] = ControlCardEntity(
          assistance1: isFirstAssistant == true
              ? newCC.assistance1
              : newCC.assistance1 ?? ccEntityList[i].assistance1,
          assistance2: newCC.assistance2 ?? ccEntityList[i].assistance2,
          meetingNumber: newCC.meetingNumber ?? ccEntityList[i].meetingNumber,
        );
      }
    }
    return ccEntityList;
  }
}
