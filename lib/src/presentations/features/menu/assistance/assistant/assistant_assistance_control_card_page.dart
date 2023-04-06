import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/assistance_status_badge.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/control_card.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantAssistanceControlCardPage extends StatelessWidget {
  final String practicumId;
  final DetailProfileEntity student;

  const AssistantAssistanceControlCardPage({
    super.key,
    required this.practicumId,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final practicumKey =
        student.userPracticums!.keys.where((e) => e == practicumId).first;

    final classroom = student.userPracticums![practicumKey]!.classroom;
    final group = student.userPracticums![practicumKey]!.group;

    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Kartu Kontrol',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: 300,
                    width: AppSize.getAppWidth(context),
                  ),
                  Container(
                    height: 150,
                    color: Palette.purple80,
                  ),
                  Positioned(
                    bottom: 150,
                    right: 0,
                    child: RotatedBox(
                      quarterTurns: -2,
                      child: SvgPicture.asset(
                        AssetPath.getVector('bg_attribute.svg'),
                        height: 150,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 0,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: SvgPicture.asset(
                        AssetPath.getVector('bg_attribute.svg'),
                        color: Palette.disable.withOpacity(.4),
                        height: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 162,
                    right: 12,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: GestureDetector(
                            onTap: () {
                              ReusableHelper.onPressedSocialMediaIcon(
                                context,
                                socialMedia: 'Github',
                                isAvailable: student.github!.isNotEmpty,
                                uri: student.github!,
                              );
                            },
                            child: SvgPicture.asset(
                              AssetPath.getIcon('github_filled.svg'),
                              width: 24,
                              color: Palette.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: GestureDetector(
                            onTap: () {
                              ReusableHelper.onPressedSocialMediaIcon(
                                context,
                                socialMedia: 'Instagram',
                                isAvailable: student.instagram!.isNotEmpty,
                                uri: student.instagram!,
                              );
                            },
                            child: SvgPicture.asset(
                              AssetPath.getIcon('instagram_filled.svg'),
                              width: 24,
                              color: Palette.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 80,
                    child: SizedBox(
                      width: AppSize.getAppWidth(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: student,
                                  child: CircleNetworkImage(
                                    width: 100,
                                    height: 100,
                                    imgUrl: student.profilePhoto!,
                                    placeholderSize: 32,
                                    errorIcon: Icons.person_rounded,
                                    withBorder: true,
                                    borderWidth: 2,
                                    borderColor: Palette.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '${student.fullName}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Palette.purple80,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${student.username}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: kTextTheme.titleSmall?.copyWith(
                                    color: Palette.purple70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Palette.purple60,
                                  ),
                                  child: Text(
                                    '${classroom?.practicum?.course} ${classroom?.classCode}',
                                    style: kTextTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Palette.white,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Palette.plum60,
                                  ),
                                  child: Text(
                                    'Group Asistensi ${group?.name}',
                                    style: kTextTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Palette.white,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: courses.length,
                  (_, i) => buildControlCard(context, courses[i]),
                ),
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
    );
  }
}

void showAssistantAssistanceControlCardPage(
  BuildContext context, {
  required String practicumId,
  required DetailProfileEntity student,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantAssistanceControlCardPage(
        practicumId: practicumId,
        student: student,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistanceControlCardPage,
      ),
    ),
  );
}
