import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/student_assistance_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/student_assistance_practitioner_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/assistance_status_badge.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/control_card.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/student_avatar.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';

class StudentAssistancePage extends StatefulWidget {
  final String userId;
  final String groupId;
  final String practicumId;

  const StudentAssistancePage({
    super.key,
    required this.userId,
    required this.groupId,
    required this.practicumId,
  });

  @override
  State<StudentAssistancePage> createState() => _StudentAssistancePageState();
}

class _StudentAssistancePageState extends State<StudentAssistancePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<AssistanceNotifier>(context, listen: false)
          .getDetail(uuid: widget.groupId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssistanceNotifier>(
      builder: (context, assistanceNotifier, child) {
        if (assistanceNotifier.isSuccessState('single')) {
          return buildMainPage(
            context,
            assistanceGroup: assistanceNotifier.data,
          );
        }

        if (assistanceNotifier.isErrorState('single')) {
          return const Center(
            child: Text('unknown error occured'),
          );
        }

        return const AscoLoading();
      },
    );
  }

  Scaffold buildMainPage(
    BuildContext context, {
    required AssistanceGroupEntity? assistanceGroup,
  }) {
    final self =
        assistanceGroup?.students?.where((e) => e.uid == widget.userId).first;

    final students = <ProfileEntity>[
      self!.copyWith(nickName: 'You'),
      ...?assistanceGroup?.students?.where((e) => e.uid != widget.userId),
    ];

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
                            'Group Asistensi ${assistanceGroup?.name}',
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
                            leading: CircleNetworkImage(
                              width: 56,
                              height: 56,
                              imgUrl:
                                  '${assistanceGroup?.assistant?.profilePhoto}',
                              placeholderSize: 20,
                              errorIcon: Icons.person_rounded,
                              withBorder: true,
                              borderWidth: 2,
                              borderColor: Palette.purple60,
                            ),
                            title: Text(
                              'Asisten',
                              style: kTextTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.purple60,
                              ),
                            ),
                            subtitle: Text(
                              '${assistanceGroup?.assistant?.fullName}',
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
                          context.read<ProfileNotifier>().reset();

                          showStudentAssistancePractitionerPage(
                            context,
                            groupName: assistanceGroup!.name!,
                            practicumId: widget.practicumId,
                          );
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
      trailing: AssistanceStatusBadge(course: course),
      onTap: course.isLocked
          ? null
          : () => showStudentAssistanceCourseDetailPage(context),
    );
  }
}
