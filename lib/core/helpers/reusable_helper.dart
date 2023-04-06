import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:asco/core/helpers/time_helper.dart';
import 'package:asco/core/states/attendance_state.dart';
import 'package:asco/core/utils/snack_bar_utils.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/user_practicum_helper.dart';
import 'package:asco/src/presentations/widgets/snack_bar/content_type.dart';

class ReusableHelper {
  /// Hashing password
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }

  /// Create title-case
  static String titleMaker(String title) {
    final listTitle = title.split(' ');

    var newTitle = '';

    for (var t in listTitle) {
      newTitle += "${t[0].toUpperCase()}${t.substring(1, t.length)} ";
    }

    return newTitle.trim();
  }

  /// Create nickname from students fullname
  static String nicknameGenerator(String fullname) {
    final listName = fullname.trim().split(' ');

    return listName.length <= 1 ? fullname : listName[1];
  }

  /// Time formatter
  static String timeFormatter(TimeHelper th) {
    final startTime = '${th.startHour}:${th.startMinute}';
    final endTime = '${th.endHour}:${th.endMinute}';

    final startTimeList = startTime.split(':');
    final startTime1 = startTimeList.first.padLeft(2, "0");
    final startTime2 = startTimeList.last.padLeft(2, "0");

    final endTimeList = endTime.split(':');
    final endTime1 = endTimeList.first.padLeft(2, "0");
    final endTime2 = endTimeList.last.padLeft(2, "0");

    return '$startTime1:$startTime2 - $endTime1:$endTime2';
  }

  /// Convert DateTime to String
  static String dateTimeToString(
    DateTime date, {
    bool isShowTime = false,
    String? format,
  }) {
    return isShowTime
        ? DateFormat(format ?? 'HH:MM, dd MMMM yyyy', "id_ID").format(date)
        : DateFormat(format ?? 'EEEE, dd MMMM yyyy', "id_ID").format(date);
  }

  /// Convert String to DateTime
  static DateTime stringToDateTime(String date, {bool isShowTime = false}) {
    return isShowTime
        ? DateFormat('HH:MM, dd MMMM yyyy', "id_ID").parse(date)
        : DateFormat("EEEE, dd MMMM yyyy", "id_ID").parse(date);
  }

  static Map<AttendanceState, int> calculateAttendanceStat(
      List<AttendanceEntity> attendances) {
    final status = <AttendanceState>[
      AttendanceState.attend,
      AttendanceState.ache,
      AttendanceState.leave,
      AttendanceState.absent,
    ];

    final attendanceMap = <AttendanceState, int>{};

    for (var i = 0; i < status.length; i++) {
      final value = attendances
          .where((attendance) => attendance.attendanceStatus == i)
          .length;

      attendanceMap[status[i]] = value;
    }

    return attendanceMap;
  }

  static String createPredictId(List<AssistanceGroupEntity> listData) {
    var i = 1;

    while (true) {
      final index = listData.indexWhere((data) => data.name! == i.toString());

      if (index != -1) {
        i++;
      } else {
        break;
      }
    }

    return i.toString();
  }

  static Map<String, Map<String, UserPracticumHelper>> getPracticumData({
    required List<DetailProfileEntity> allData,
    required List<ProfileEntity> selectData,
    String? practicumUid,
    String? classroomUid,
    String? groupUid,
  }) {
    try {
      final data = <String, Map<String, UserPracticumHelper>>{};

      for (var profile in selectData) {
        final uid = allData.indexWhere((entity) => profile.uid == entity.uid);

        final practicumMap = <String, UserPracticumHelper>{};
        if (allData[uid].userPracticums != null) {
          final current = allData[uid].userPracticums!;

          for (var k in current.keys) {
            practicumMap[k] = UserPracticumHelper(
              classroomUid: current[k]?.classroom?.uid,
              groupUid: current[k]?.group?.uid,
            );
          }

          final temp = UserPracticumHelper(
            classroomUid: classroomUid,
            groupUid: groupUid,
          );

          if (!practicumMap.containsKey(practicumUid)) {
            practicumMap[practicumUid!] = temp;
          } else {
            if (practicumMap.containsValue(temp)) {
              continue;
            } else {
              practicumMap[practicumUid!] = UserPracticumHelper(
                classroomUid:
                    classroomUid ?? practicumMap[practicumUid]!.classroomUid,
                groupUid: groupUid ?? practicumMap[practicumUid]!.groupUid,
              );
            }
          }
        }

        data[profile.uid!] = practicumMap;
      }

      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> urlLauncher(String uri) async {
    final Uri url = Uri.parse(uri);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static void onPressedSocialMediaIcon(
    BuildContext context, {
    required bool isAvailable,
    required String uri,
    required String socialMedia,
    String? title,
    String? message,
  }) async {
    if (isAvailable) {
      await urlLauncher(uri);
    } else {
      final snackbar = SnackBarUtils.createSnackBar(
        title: title ?? '$socialMedia Tidak Ada',
        message: message ?? 'Siswa belum melengkapi akun $socialMedia',
        type: ContentType.help,
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar);
    }
  }
}
