import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageAsset;
  final double radius;

  const Avatar({
    super.key,
    required this.imageAsset,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Palette.white,
      ),
      padding: const EdgeInsets.all(2.0),
      child: CircleAvatar(
        radius: radius,
        foregroundImage: AssetImage(
          AssetPath.getImage(imageAsset),
        ),
      ),
    );
  }
}
