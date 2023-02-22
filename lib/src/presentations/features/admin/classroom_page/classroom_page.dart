import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/classroom_page/meeting_page.dart';
import 'package:asco/src/presentations/features/admin/reusable_sections/all_classroom_section.dart';
import 'package:flutter/material.dart';

void showAdminClassroomPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminClassroomPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminClassroomPage extends StatelessWidget {
  const AdminClassroomPage({super.key});
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
          'Data Kelas',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AdminAllClassroomSection(
          onCardTap: (c) {
            return () {
              showAdminClassroomMeetingPage(
                context: context,
                classroomId: c.uid!,
                students: c.students ?? [],
              );
            };
          },
        ),
      ),
    );
  }
}
