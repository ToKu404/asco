import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/student_assistance_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/student_assistance_practitioner_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/assistance_status_badge.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/control_card.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/student_avatar.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';

class StudentAssistancePage extends StatefulWidget {
  final String? groupId;
  
  const StudentAssistancePage({super.key, required this.groupId});

  @override
  State<StudentAssistancePage> createState() => _StudentAssistancePageState();
}

class _StudentAssistancePageState extends State<StudentAssistancePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<AssistanceNotifier>(context, listen: false)
            ..getDetail(uuid: widget.groupId!),
        });
  }

  @override
  Widget build(BuildContext context) {
    final groupNotifier = context.watch<AssistanceNotifier>();

    if (groupNotifier.isLoadingState('single') || groupNotifier.data == null) {
      return const AscoLoading(
        withScaffold: true,
      );
    }
    final groupEntity = groupNotifier.data;
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
                            'Grup Asistensi ${groupEntity?.name}',
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
                              '${groupEntity?.assistant?.fullName}',
                              style: kTextTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Palette.purple100,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                AssetPath.getIcon('github_filled.svg'),
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
                        onTap: () {
                          showStudentAssistancePractitionerPage(context);
                        },
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return StudentAvatar(student: groupEntity.students![index]);
                },
                itemCount: groupEntity!.students!.length,
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
      trailing: AssistanceStatusBadge(course: course),
      onTap: course.isLocked
          ? null
          : () => showStudentAssistanceCourseDetailPage(context),
    );
  }
}
