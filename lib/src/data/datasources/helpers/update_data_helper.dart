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
          attendanceStatus: updateAttendance.attendanceStatus,
          pointPlus: updateAttendance.pointPlus,
          note: updateAttendance.note,
          attendanceTime: updateAttendance.attendanceTime,
          uuid: attendanceList[i].uuid,
          studentUid: attendanceList[i].studentUid,
        );
      }
    }

    return attendanceList;
  }
}
