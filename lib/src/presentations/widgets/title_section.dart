import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final double paddingBottom;

  const TitleSection({
    super.key,
    required this.title,
    this.paddingBottom = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Text(
        title,
        style: kTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Palette.purple100,
        ),
      ),
    );
  }
}
