import 'package:asco/core/helpers/asset_path.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageAsset;
  final double radius;
  final Color color;

  const Avatar({
    super.key,
    required this.imageAsset,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
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
