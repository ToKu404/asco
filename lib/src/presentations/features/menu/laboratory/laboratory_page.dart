import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/laboratory/laboratory_course_detail_page.dart';

class StudentLaboratoryPage extends StatelessWidget {
  const StudentLaboratoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    const labMenuCards = <MenuCard>[
      MenuCard(
        title: 'Tata Tertib',
        strokeColor: Palette.purple40,
        fillColor: Palette.purple20,
        iconName: 'card_list_outlined.svg',
      ),
      MenuCard(
        title: 'Kontrak Kuliah',
        strokeColor: Palette.salmon40,
        fillColor: Palette.salmon20,
        iconName: 'file_contract_outlined.svg',
      ),
      MenuCard(
        title: 'Rekap Materi',
        strokeColor: Palette.plum40,
        fillColor: Palette.plum20,
        iconName: 'book_outlined.svg',
      ),
      MenuCard(
        title: 'Riwayat Kehadiran',
        strokeColor: Palette.azure40,
        fillColor: Palette.azure20,
        iconName: 'history_outlined.svg',
      ),
    ];

    const labCourses = <Course>[
      Course(3, 'Studi Kasus: E-Wallet App', '10 Maret 2023'),
      Course(2, 'Buat Aplikasi Android Pertamamu!', '3 Maret 2023'),
      Course(1, 'Mengenal Bahasa Pemrograman Kotlin', '27 Februari 2023'),
    ];

    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  bottom: -8,
                  child: Container(
                    width: AppSize.getAppWidth(context) - 80,
                    height: 16,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      color: Palette.purple100,
                    ),
                  ),
                ),
                Container(
                  width: AppSize.getAppWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Palette.purple60,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Pemrograman Mobile A',
                                style: kTextTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Palette.white,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Setiap hari Senin Pukul 10.10 - 12.40',
                                style: kTextTheme.bodyMedium?.copyWith(
                                  color: Palette.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 43,
                          height: 47,
                          child: SvgPicture.asset(
                            AssetPath.getVector('badge_android.svg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: labMenuCards,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pertemuan',
                    style: kTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.purple100,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AssetPath.getIcons('arrow_sort_filled.svg'),
                      color: Palette.purple100,
                      width: 20,
                    ),
                    tooltip: 'Sort',
                  )
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton(
                onPressed: null,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 2,
                    color: Palette.white,
                  ),
                  foregroundColor: Palette.white,
                  disabledForegroundColor: Palette.white,
                  backgroundColor: Palette.purple60.withOpacity(.4),
                  disabledBackgroundColor: Palette.purple60.withOpacity(.4),
                ),
                child: const Text('Pertemuan 4 Segera...'),
              ),
            ),
            const SizedBox(height: 8),
            ...labCourses
                .map(
                  (course) => MeetingCard(
                    course: course,
                    courseNumberBackgroundColor: Palette.purple100,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final Color strokeColor;
  final Color fillColor;
  final String iconName;

  const MenuCard({
    super.key,
    required this.title,
    required this.strokeColor,
    required this.fillColor,
    required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Palette.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: 68,
          height: 92,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 2,
                        color: strokeColor,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetPath.getIcons(iconName),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: kTextTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: strokeColor,
                    letterSpacing: 0,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MeetingCard extends StatelessWidget {
  final Course course;
  final Color courseNumberBackgroundColor;

  const MeetingCard({
    super.key,
    required this.course,
    required this.courseNumberBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Palette.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentLaboratoriumCourseDetailPage(),
              settings: const RouteSettings(
                name: AppRoute.studentLaboratoriumCourseDetailPage,
              ),
            ),
          ),
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: courseNumberBackgroundColor,
                    child: Text(
                      '#${course.number}',
                      style: kTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          course.topic,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kTextTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple100,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kTextTheme.bodyMedium?.copyWith(
                            color: Palette.purple60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Course {
  final int number;
  final String topic;
  final String date;

  const Course(this.number, this.topic, this.date);
}
