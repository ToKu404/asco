import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/student_assistance_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/control_card.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/student_avatar.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';

class StudentAssistancePage extends StatelessWidget {
  const StudentAssistancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
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
                  Container(
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
                  const SizedBox(height: 24),
                  Row(
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
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, i) => StudentAvatar(student: students[i]),
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemCount: students.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
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
                        style: kTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Palette.purple60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...courses
                      .map((course) => buildControlCard(context, course))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ControlCard buildControlCard(BuildContext context, Course course) {
    return ControlCard(
      course: course,
      hasTrailing: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (course.isLocked) ...[
            const CircleBorderContainer(size: 30),
            const SizedBox(width: 4),
            const CircleBorderContainer(size: 30),
          ] else ...[
            const CircleBorderContainer(
              size: 30,
              borderColor: Palette.purple80,
              fillColor: Palette.purple60,
              child: Icon(
                Icons.check_rounded,
                size: 16,
                color: Palette.white,
              ),
            ),
            const SizedBox(width: 4),
            const CircleBorderContainer(
              size: 30,
              borderColor: Color(0xFFD35380),
              fillColor: Color(0xFFFA78A6),
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: Palette.white,
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StudentAssistanceCourseDetailPage(),
            settings: const RouteSettings(
              name: AppRoute.studentAssistanceCourseDetailPage,
            ),
          ),
        );
      },
    );
  }
}
