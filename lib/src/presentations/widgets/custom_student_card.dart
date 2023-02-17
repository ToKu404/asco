import 'package:flutter/material.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';

class CustomStudentCard extends StatelessWidget {
  final Student student;
  final bool hasAvatarBorder;
  final bool hasTrailing;
  final Widget? trailing;
  final bool isThreeLine;
  final Widget? thirdLine;
  final VoidCallback? onTap;

  const CustomStudentCard({
    super.key,
    required this.student,
    this.hasAvatarBorder = false,
    this.hasTrailing = false,
    this.isThreeLine = false,
    this.trailing,
    this.thirdLine,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Palette.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 28,
                backgroundColor: Palette.purple80,
                child: Hero(
                  tag: student,
                  child: CircleAvatar(
                    radius: hasAvatarBorder ? 26 : 28,
                    foregroundImage: AssetImage(
                      AssetPath.getImage('avatar${student.id}.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      student.nim,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      student.name,
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.purple80,
                        height: 1.2,
                      ),
                    ),
                    if (isThreeLine) ...[
                      const SizedBox(height: 4),
                      thirdLine!,
                    ],
                  ],
                ),
              ),
              if (hasTrailing) ...[
                const SizedBox(width: 8),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
