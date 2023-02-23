import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/reusable_helper.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/presentations/features/admin/attendance_page/attendance_users_page.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';

class AdminAttendanceCard extends StatefulWidget {
  final DetailMeetingEntity entity;
  final int number;
  const AdminAttendanceCard({
    required this.entity,
    required this.number,
    super.key,
  });

  @override
  State<AdminAttendanceCard> createState() => _AdminAttendanceCardState();
}

class _AdminAttendanceCardState extends State<AdminAttendanceCard> {
  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      padding: const EdgeInsets.all(
        12,
      ),
      radius: 12,
      color: Palette.white,
      onTap: () {
        showAdminAttendanceUsersPage(
          context: context,
          attendances: widget.entity.attendances ?? [],
          number: widget.number,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pertemuan ${widget.number}',
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple80,
                        height: 1,
                      ),
                    ),
                    Text(
                      widget.entity.topic!,
                      style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ReusableHelper.datetimeToString(
                        widget.entity.meetingDate!,
                      ),
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.greyDark,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          _BuildMeetStat(
            widget.entity.attendances ?? [],
          ),
        ],
      ),
    );
  }
}

class _BuildMeetStat extends StatelessWidget {
  final List<AttendanceEntity> attendaces;
  const _BuildMeetStat(this.attendaces);

  @override
  Widget build(BuildContext context) {
    final statData = ReusableHelper.calculateAttendanceStat(attendaces);
    return Column(
      children: [
        Row(children: [
          Flexible(
            flex: statData[AttendanceStatus.hadir] ?? 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.purple60,
              ),
            ),
          ),
          if (statData[AttendanceStatus.hadir] != 0)
            const SizedBox(
              width: 4,
            ),
          Flexible(
            flex: statData[AttendanceStatus.sakit] ?? 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.orange20,
              ),
            ),
          ),
          if (statData[AttendanceStatus.sakit] != 0)
            const SizedBox(
              width: 4,
            ),
          Flexible(
            flex: statData[AttendanceStatus.izin] ?? 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.azure40,
              ),
            ),
          ),
          if (statData[AttendanceStatus.izin] != 0)
            const SizedBox(
              width: 4,
            ),
          Flexible(
            flex: statData[AttendanceStatus.tidakHadir] ?? 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.plum60),
            ),
          ),
        ]),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: statData.entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _DetailCoursePercent(
                    absentStatus: e.key,
                    value: e.value,
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

enum AttendanceStatus { hadir, izin, tidakHadir, sakit }

class AbsentData {
  final String title;
  final Color color;
  String? path;

  AbsentData({
    required this.title,
    required this.color,
    this.path,
  });
}

class _DetailCoursePercent extends StatelessWidget {
  final AttendanceStatus absentStatus;
  final int value;
  const _DetailCoursePercent({
    required this.absentStatus,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final Map<AttendanceStatus, AbsentData> data = {
      AttendanceStatus.hadir: AbsentData(
        title: 'Hadir',
        color: Palette.purple60,
      ),
      AttendanceStatus.sakit:
          AbsentData(title: 'Sakit', color: Palette.orange20),
      AttendanceStatus.izin: AbsentData(title: 'Izin', color: Palette.azure40),
      AttendanceStatus.tidakHadir:
          AbsentData(title: 'Alfa', color: Palette.plum60),
    };

    return Row(
      children: [
        Text(
          value.toString(),
          style: kTextTheme.bodyMedium?.copyWith(
            color: data[absentStatus]!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          data[absentStatus]!.title,
          style: kTextTheme.bodyMedium?.copyWith(
            color: data[absentStatus]!.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
