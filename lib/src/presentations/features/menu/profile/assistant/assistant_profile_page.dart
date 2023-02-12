import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/title_section.dart';

class AssistantProfilePage extends StatelessWidget {
  const AssistantProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: AppSize.getAppWidth(context),
                color: Palette.purple80,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: RotatedBox(
                  quarterTurns: -2,
                  child: SvgPicture.asset(
                    AssetPath.getVector('bg_attribute.svg'),
                  ),
                ),
              ),
              Positioned(
                  bottom: 12,
                  right: 16,
                  child: Row(
                    children: [
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
                      SizedBox(
                        width: 8,
                      ),
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
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Data Diri',
              style: kTextTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Palette.white,
              ),
            ),
          ),
          Positioned(
            top: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Colors.white,
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                AssetPath.getImage('avatar1.jpg'),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Muh. Ikhsan',
                    style: kTextTheme.titleLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '@toku404',
                    style: kTextTheme.titleSmall
                        ?.copyWith(color: Palette.purple70, height: 1.2),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.purple80,
                      ),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AssetPath.getIcons(
                          'edit.svg',
                        ),
                        color: Palette.white,
                        width: 20,
                        height: 20,
                      ),
                      label: Text(
                        'Edit',
                        style: kTextTheme.bodyMedium
                            ?.copyWith(color: Palette.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const TitleSection(title: 'Badges'),
                  const SizedBox(
                    height: 8,
                  ),
                  BadgeCard(
                    title: 'Asisten Pemrograman Mobile',
                    badgePath: AssetPath.getVector(
                      'badge_oop.svg',
                    ),
                  ),
                  BadgeCard(
                    title: 'Pemateri Pemrograman Mobile',
                    badgePath: AssetPath.getVector(
                      'badge_oop.svg',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    required this.title,
    required this.badgePath,
  });

  final String title;
  final String badgePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getAppWidth(context) - 28 * 2,
      height: 60,
      margin: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(left: 4, top: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Palette.purple80,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(right: 4, bottom: 3),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Palette.purple60),
                borderRadius: BorderRadius.circular(16),
                color: Palette.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 27,
                    child: SvgPicture.asset(
                      badgePath,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    title,
                    style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.purple70,
                        fontWeight: FontWeight.w400,
                        height: 1.05),
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
