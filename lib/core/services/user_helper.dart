import 'dart:convert';
import 'package:asco/src/domain/entities/assistance_entities/assistance_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_entity.dart';
import 'package:asco/src/presentations/features/admin/attendance_page/widgets/attendance_card.dart';
import 'package:asco/src/presentations/widgets/input_field/input_time_field.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class ReusableHelper {
  /// Hashing password
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Membuat nama depan jadi huruf kapital
  static String titleMaker(String title) {
    final listTitle = title.split(' ');
    String newTitle = '';
    for (var t in listTitle) {
      newTitle += "${t[0].toUpperCase()}${t.substring(1, t.length)} ";
    }
    return newTitle.trim();
  }

  /// membuat nama panggilan dari nama lengkap
  static String nicknameGenerator(String fullname) {
    final listName = fullname.trim().split(' ');
    if (listName.length <= 1) {
      return fullname;
    } else {
      return listName[1];
    }
  }

  ///time
  static String timeFormater(TimeHelper th) {
    final startTime = '${th.startHour}:${th.startMinute}';
    final endTime = '${th.endHour}:${th.endMinute}';

    final startTimeList = startTime.split(':');
    final startTime1 = startTimeList.first.padLeft(2, "0");
    final startTime2 = startTimeList.last.padLeft(2, "0");

    final endTimeList = endTime.split(':');
    final endTime1 = endTimeList.first.padLeft(2, "0");
    final endTime2 = endTimeList.last.padLeft(2, "0");

    return '$startTime1:$startTime2-$endTime1:$endTime2';
  }

  //datetime to string
  static String datetimeToString(DateTime date,
      {bool isShowTime = false, String? format}) {
    return isShowTime
        ? DateFormat(format ?? 'HH:MM, dd MMMM yyyy', "id_ID").format(date)
        : DateFormat(format ?? 'EEEE, dd MMMM yyyy', "id_ID").format(date);
  }

  // string ke datetime
  /// Convert String to DateTime
  static DateTime stringToDateTime(String date, {bool isShowTime = false}) {
    return isShowTime
        ? DateFormat('HH:MM, dd MMMM yyyy', "id_ID").parse(date)
        : DateFormat("EEEE, dd MMMM yyyy", "id_ID").parse(date);
  }

  static Map<AttendanceStatus, int> calculateAttendanceStat(
      List<AttendanceEntity> attendaces) {
    final listStatus = [
      AttendanceStatus.hadir,
      AttendanceStatus.sakit,
      AttendanceStatus.izin,
      AttendanceStatus.tidakHadir
    ];

    final Map<AttendanceStatus, int> attendanceStat = {};
    for (int i = 0; i < listStatus.length; i++) {
      attendanceStat[listStatus[i]] =
          attendaces.where((e) => e.attendanceStatus == i).length;
    }

    return attendanceStat;
  }

  static String createPredictId(List<AssistanceGroupEntity> listData) {
    int i = 1;
    while (true) {
      int foundStatus =
          listData.indexWhere((element) => element.name! == i.toString());
      if (foundStatus != -1) {
        i++;
      } else {
        break;
      }
    }

    return i.toString();
  }

  static Map<String, List<UserPracticumEntity>> getPracticumData({
    required List<DetailProfileEntity> allData,
    required List<ProfileEntity> selectData,
    String? practicumUid,
    String? classroomUid,
    String? groupUid,
  }) {
    Map<String, List<UserPracticumEntity>> data = {};

    for (var element in selectData) {
      final idsx = allData.indexWhere((d) => element.uid == d.uid);
      final listPracticum = allData[idsx].userPracticums;

      final idx = listPracticum!
          .indexWhere((element) => element.practicumUid == practicumUid);
      final temp = UserPracticumEntity(
          practicumUid: practicumUid,
          classUid: classroomUid,
          assistanceGroupUid: groupUid);
      if (idx == -1) {
        listPracticum.add(temp);
      } else {
        if (listPracticum.contains(temp)) {
          continue;
        } else {
          UserPracticumEntity(
              practicumUid: listPracticum[idx].practicumUid,
              assistanceGroupUid:
                  groupUid ?? listPracticum[idx].assistanceGroupUid,
              classUid: classroomUid ?? listPracticum[idx].classUid);
        }
      }

      data[element.uid!] = listPracticum;
    }
    return data;
  }
}
