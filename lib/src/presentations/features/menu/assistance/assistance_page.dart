import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistance_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/laboratory_page.dart';

class StudentAssistancePage extends StatelessWidget {
  const StudentAssistancePage({super.key});

  @override
  Widget build(BuildContext context) {
    const students = <Student>[
      Student(1, 'You'),
      Student(2, 'Silverius S.'),
      Student(3, 'Muh. Ikhsan'),
      Student(4, 'Eurico Devon'),
      Student(5, 'Raf Mas'),
      Student(2, 'Ucup Cam'),
      Student(1, 'Muh. Ardan'),
      Student(5, 'Fauzi Asham'),
      Student(4, 'Muh. Cick'),
      Student(3, 'Alif Setya'),
    ];

    const courses = <Course>[
      Course(
        1,
        'Mengenal Bahasa Pemrograman Kotlin',
        '27 Feb - 3 Mar',
        isLocked: false,
      ),
      Course(
        2,
        'Buat Aplikasi Android Pertamamu!',
        '5 Mar - 10 Mar',
        isLocked: false,
      ),
      Course(
        3,
        'Studi Kasus: E-Wallet App',
        '13 Mar - 29 Apr',
        isLocked: false,
      ),
      Course(
        4,
        'Migrase ke Framework Flutter',
        'Coming Soon',
      ),
      Course(
        5,
        'Statefull dan Stateless Widget',
        'Coming Soon',
      ),
    ];

    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Palette.purple80,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: RotatedBox(
                        quarterTurns: -2,
                        child: SvgPicture.asset(
                          AssetPath.getVector('bg_attribute.svg'),
                          width: AppSize.getAppWidth(context) / 3,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      child: Text(
                        'Grup Asistensi 3',
                        style: kTextTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: SvgPicture.asset(
                          AssetPath.getVector('bg_attribute.svg'),
                          width: AppSize.getAppWidth(context) / 3,
                          color: Palette.disable.withOpacity(.4),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: ListTile(
                        horizontalTitleGap: 12,
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundColor: Palette.purple60,
                          child: CircleAvatar(
                            radius: 26,
                            foregroundImage: AssetImage(
                              AssetPath.getImage('avatar3.jpg'),
                            ),
                          ),
                        ),
                        title: Text(
                          'Asisten',
                          style: kTextTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Palette.purple60,
                          ),
                        ),
                        subtitle: Text(
                          'Eurico Devon B. P.',
                          style: kTextTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple100,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AssetPath.getIcons('github_filled.svg'),
                            width: 24,
                            color: Palette.purple80,
                          ),
                          tooltip: 'Github',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Praktikan',
                    style: kTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.purple100,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Lihat Detail',
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Palette.purple60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: ((_, i) => StudentAvatar(student: students[i])),
                separatorBuilder: ((_, __) => const SizedBox(width: 10)),
                itemCount: students.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Kartu Kontrol',
                    style: kTextTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.purple100,
                    ),
                  ),
                  Text(
                    '5 Materi',
                    style: kTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Palette.purple60,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <ControlCard>[
                  ...courses
                      .map((course) => ControlCard(course: course))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentAvatar extends StatelessWidget {
  final Student student;

  const StudentAvatar({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: Palette.white,
            child: CircleAvatar(
              radius: 28,
              foregroundImage: AssetImage(
                AssetPath.getImage('avatar${student.id}.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              student.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: kTextTheme.bodySmall?.copyWith(
                color: Palette.purple100,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ControlCard extends StatelessWidget {
  final Course course;

  const ControlCard({super.key, required this.course});

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
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentAssistanceCourseDetailPage(),
              settings: const RouteSettings(
                name: AppRoute.studentAssistanceCourseDetailPage,
              ),
            ),
          ),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Palette.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Palette.greyDark,
                      ),
                    ),
                    child: Center(
                      child: course.isLocked!
                          ? const Icon(
                              Icons.lock_outline_rounded,
                              size: 20,
                              color: Palette.greyDark,
                            )
                          : Text(
                              '${course.number}',
                              style: kTextTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Palette.greyDark,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          course.topic,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kTextTheme.bodyLarge?.copyWith(
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
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.purple60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (course.isLocked!) ...[
                        const AssistanceStatusBadge(),
                        const SizedBox(width: 4),
                        const AssistanceStatusBadge(),
                      ] else ...[
                        const AssistanceStatusBadge(
                          borderColor: Palette.purple80,
                          fillColor: Palette.purple60,
                          icon: Icons.check_rounded,
                        ),
                        const SizedBox(width: 4),
                        const AssistanceStatusBadge(
                          borderColor: Color(0xFFD35380),
                          fillColor: Color(0xFFFA78A6),
                          icon: Icons.close_rounded,
                        ),
                      ],
                    ],
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

class AssistanceStatusBadge extends StatelessWidget {
  final Color? borderColor;
  final Color? fillColor;
  final IconData? icon;

  const AssistanceStatusBadge({
    super.key,
    this.borderColor,
    this.fillColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: fillColor ?? Palette.grey,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? Palette.greyDark,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 16,
          color: Palette.white,
        ),
      ),
    );
  }
}

class Student {
  final int id;
  final String name;

  const Student(this.id, this.name);
}
