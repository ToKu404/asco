import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/score_entities/score_entities.dart';

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
        break;
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
          star: newCC.star ?? ccEntityList[i].star,
        );
        break;
      }
    }
    return ccEntityList;
  }

  static ScoreEntity updateScore(
      {required UpdateScoreType updateScoreType,
      required ScoreEntity scoreEntity,
      required double newScore}) {
    ScoreEntity se = ScoreEntity(
      studentId: scoreEntity.studentId,
      assistanceScore: updateScoreType == UpdateScoreType.assistance
          ? newScore
          : scoreEntity.assistanceScore,
      quizScore: updateScoreType == UpdateScoreType.quiz
          ? newScore
          : scoreEntity.quizScore,
      examScore: updateScoreType == UpdateScoreType.exam
          ? newScore
          : scoreEntity.examScore,
      midScore: updateScoreType == UpdateScoreType.mid
          ? newScore
          : scoreEntity.midScore,
    );
    se.recapScore = (se.assistanceScore ?? 0.0 * .4) +
        (((se.midScore ?? 0.0) + (se.examScore ?? 0.0)) / 2.0 * .3) +
        ((se.quizScore ?? 0.0) * .3);
    if (se.recapScore! >= 90) {
      se.predicate = 'A';
    } else if (se.recapScore! >= 85) {
      se.predicate = 'A-';
    } else if (se.recapScore! >= 80) {
      se.predicate = 'B+';
    } else if (se.recapScore! >= 75) {
      se.predicate = 'B';
    } else if (se.recapScore! >= 70) {
      se.predicate = 'B-';
    } else if (se.recapScore! >= 65) {
      se.predicate = 'C+';
    } else if (se.recapScore! >= 60) {
      se.predicate = 'C';
    } else if (se.recapScore! >= 55) {
      se.predicate = 'C-';
    } else if (se.recapScore! >= 50) {
      se.predicate = 'D';
    } else {
      se.predicate = 'E';
    }
    return se;
  }
}

enum UpdateScoreType { quiz, assistance, mid, exam }
