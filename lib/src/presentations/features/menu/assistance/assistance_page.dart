import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';

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
                            width: 28,
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
          ],
        ),
      ),
    );
  }
}
