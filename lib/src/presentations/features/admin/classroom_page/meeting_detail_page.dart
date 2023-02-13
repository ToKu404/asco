import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_practicum_page.dart';
import 'package:flutter/material.dart';

void showAdminMeetingDetailPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const MeetingDetailPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class MeetingDetailPage extends StatelessWidget {
  const MeetingDetailPage({super.key});

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
        actions: [
          IconButton(
            onPressed: () {
              showAdminCreatePracticumPage(context: context, isEdit: true);
            },
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Palette.white,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppSize.getAppWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.white,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Materi',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Tipe data dan attribute',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Tanggal Pertemuan',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      '20 Februari 2023',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pukul',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      '10.00 - 12.00 WITA',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pemateri',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Jiao',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pendamping',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Jiao',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
