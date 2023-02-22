import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/reusable_sections/all_practicum_section.dart';
import 'package:asco/src/presentations/features/admin/score_page/score_page.dart';
import 'package:flutter/material.dart';

void showAdminScorePracticumPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminScorePracticumPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminScorePracticumPage extends StatelessWidget {
  const AdminScorePracticumPage({super.key});

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
          'Data Nilai',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: AdminAllPracticumSection(
        onCardTap: (pr) {
          return () {
            showAdminScorePage(context: context);
          };
        },
      )),
    );
  }
}
