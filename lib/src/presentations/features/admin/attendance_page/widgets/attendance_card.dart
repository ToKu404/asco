import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/attendance_page/attendance_users_page.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';

class AdminAttendanceCard extends StatefulWidget {
  const AdminAttendanceCard({
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
        showAdminAttendanceUsersPage(context: context);
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
                      'Pertemuan 1',
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple80,
                        height: 1,
                      ),
                    ),
                    Text(
                      'Tipe Data dan Attribute',
                      style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '25 Nov 2023',
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
          const _BuildMeetStat(),
        ],
      ),
    );
  }
}

class _BuildMeetStat extends StatelessWidget {
  const _BuildMeetStat();

  @override
  Widget build(BuildContext context) {
    final statData = [12, 2, 1, 1];
    return Column(
      children: [
        Row(
          children: [
            if (statData[0] != 0)
              Flexible(
                flex: statData[0],
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.purple60,
                  ),
                ),
              ),
            if (statData[1] != 0) ...[
              const SizedBox(
                width: 4,
              ),
              Flexible(
                flex: statData[1],
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.orange20,
                  ),
                ),
              ),
            ],
            if (statData[2] != 0) ...[
              const SizedBox(
                width: 4,
              ),
              Flexible(
                flex: statData[2],
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.azure20,
                  ),
                ),
              ),
            ],
            if (statData[3] != 0) ...[
              const SizedBox(
                width: 4,
              ),
              Flexible(
                flex: statData[3],
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.plum40,
                  ),
                ),
              ),
            ]
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: const [
            _DetailCoursePercent(
              absentStatus: AbsentStatus.hadir,
              value: 12,
            ),
            SizedBox(
              width: 8,
            ),
            _DetailCoursePercent(
              absentStatus: AbsentStatus.sakit,
              value: 1,
            ),
            SizedBox(
              width: 8,
            ),
            _DetailCoursePercent(
              absentStatus: AbsentStatus.izin,
              value: 1,
            ),
            SizedBox(
              width: 8,
            ),
            _DetailCoursePercent(
              absentStatus: AbsentStatus.tidakHadir,
              value: 2,
            ),
          ],
        )
      ],
    );
  }
}

enum AbsentStatus { hadir, izin, tidakHadir, sakit }

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
  final AbsentStatus absentStatus;
  final int value;
  const _DetailCoursePercent({
    required this.absentStatus,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final Map<AbsentStatus, AbsentData> data = {
      AbsentStatus.hadir: AbsentData(
        title: 'Hadir',
        color: Palette.purple60,
      ),
      AbsentStatus.sakit: AbsentData(title: 'Sakit', color: Palette.orange20),
      AbsentStatus.izin: AbsentData(title: 'Izin', color: Palette.azure40),
      AbsentStatus.tidakHadir: AbsentData(title: 'Alfa', color: Palette.plum60),
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
