import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

class TempBadgeHelper {
  final int badgeId;
  final String title;

  TempBadgeHelper({required this.badgeId, required this.title});
}

class BuildBadge extends StatelessWidget {
  final _badge = [
    Palette.purple100,
    Palette.purple80,
    Palette.plum80,
    Palette.purple60,
    Palette.plum60,
  ];

  final TempBadgeHelper badgeHelper;

  BuildBadge({super.key, required this.badgeHelper});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _badge[badgeHelper.badgeId],
      ),
      child: Text(
        badgeHelper.title,
        style: kTextTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Palette.white,
          height: 1,
        ),
      ),
    );
  }
}
