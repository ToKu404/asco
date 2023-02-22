import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/attendance_page/attendance_page.dart';
import 'package:asco/src/presentations/features/admin/reusable_sections/all_classroom_section.dart';
import 'package:flutter/material.dart';

void showAdminAttendanceClassroomPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminAttendanceClassroomPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminAttendanceClassroomPage extends StatelessWidget {
  const AdminAttendanceClassroomPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Palette.white,
          ),
        ),
        title: Text(
          'Data Absensi Kelas',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AdminAllClassroomSection(
          onCardTap: (c) {
            return () {
              showAdminAttendancePage(context: context, classroomUid: c.uid!);
            };
          },
        ),
      ),
    );
  }
}
