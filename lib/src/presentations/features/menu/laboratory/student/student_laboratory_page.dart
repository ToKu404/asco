import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/laboratory/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/laboratory/student/student_laboratory_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/meeting_card.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/menu_card.dart';

class StudentLaboratoryPage extends StatelessWidget {
  const StudentLaboratoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<MenuCard> labMenuCards = <MenuCard>[
      MenuCard(
        title: 'Tata Tertib',
        strokeColor: Palette.purple40,
        fillColor: Palette.purple20,
        iconName: 'card_list_outlined.svg',
        onTap: () {},
      ),
      MenuCard(
        title: 'Kontrak Kuliah',
        strokeColor: Palette.salmon40,
        fillColor: Palette.salmon20,
        iconName: 'file_contract_outlined.svg',
        onTap: () {},
      ),
      MenuCard(
        title: 'Rekap Materi',
        strokeColor: Palette.plum40,
        fillColor: Palette.plum20,
        iconName: 'book_outlined.svg',
        onTap: () {},
      ),
      MenuCard(
        title: 'Riwayat Kehadiran',
        strokeColor: Palette.azure40,
        fillColor: Palette.azure20,
        iconName: 'history_outlined.svg',
        onTap: () {},
      ),
    ];

    const labCourses = <Course>[
      Course(
        3,
        'Studi Kasus: E-Wallet App',
        '10 Maret 2023',
      ),
      Course(
        2,
        'Buat Aplikasi Android Pertamamu!',
        '3 Maret 2023',
      ),
      Course(
        1,
        'Mengenal Bahasa Pemrograman Kotlin',
        '27 Februari 2023',
      ),
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
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 16 / 7,
                shrinkWrap: true,
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
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const StudentLaboratoryCourseDetailPage();
                        },
                        settings: const RouteSettings(
                          name: AppRoute.studentLaboratoryCourseDetailPage,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}