import 'package:flutter/material.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';

class MentorTile extends StatelessWidget {
  final String name;
  final String role;
  final String assetName;

  const MentorTile({
    super.key,
    required this.name,
    required this.role,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Palette.disable,
        foregroundImage: AssetImage(
          AssetPath.getImage(assetName),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Palette.white,
        ),
      ),
      subtitle: Text(
        role,
        style: TextStyle(
          color: Palette.white.withOpacity(.75),
        ),
      ),
    );
  }
}
