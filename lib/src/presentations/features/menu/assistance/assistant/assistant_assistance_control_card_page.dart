import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/assistance_status_badge.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/control_card.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantAssistanceControlCardPage extends StatelessWidget {
  final Student student;

  const AssistantAssistanceControlCardPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
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
                clipBehavior: Clip.none,
                children: <Widget>[
                  SizedBox(
                    height: 300,
                    width: AppSize.getAppWidth(context),
                  ),
                  Container(
                    height: 150,
                    width: AppSize.getAppWidth(context),
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
                            onTap: () {},
                            child: SvgPicture.asset(
                              AssetPath.getIcons('github_filled.svg'),
                              width: 24,
                              color: Palette.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              AssetPath.getIcons('instagram_filled.svg'),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Palette.white,
                              child: Hero(
                                tag: student,
                                child: CircleAvatar(
                                  radius: 48,
                                  foregroundImage: AssetImage(
                                    AssetPath.getImage(
                                      'avatar${student.id}.jpg',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              student.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: kTextTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Palette.purple80,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              student.nim,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: kTextTheme.titleSmall?.copyWith(
                                color: Palette.purple70,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
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
                                    'Pemrograman Mobile A',
                                    style: kTextTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Palette.white,
                                      height: 1,
                                    ),
                                  ),
                                ),
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
                                    'Grup Asistensi 16',
                                    style: kTextTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Palette.white,
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 14),
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
  BuildContext context,
  Student student,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantAssistanceControlCardPage(student: student),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistanceControlCardPage,
      ),
    ),
  );
}
