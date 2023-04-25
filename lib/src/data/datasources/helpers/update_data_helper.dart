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
}
