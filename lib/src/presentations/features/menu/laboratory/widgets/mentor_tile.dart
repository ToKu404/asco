import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/presentations/widgets/custom_network_image.dart';

class MentorTile extends StatelessWidget {
  final String name;
  final String role;
  final String image;

  const MentorTile({
    super.key,
    required this.name,
    required this.role,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CustomNetworkImage(
          width: 44,
          height: 44,
          imgUrl: image,
          placeholderSize: 16,
          errorIcon: Icons.person_rounded,
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
