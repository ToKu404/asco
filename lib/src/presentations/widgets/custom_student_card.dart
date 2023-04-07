import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';

class CustomStudentCard extends StatelessWidget {
  final ProfileEntity? student;
  final DetailProfileEntity? studentDetail;
  final bool hasAvatarBorder;
  final bool hasTrailing;
  final Widget? trailing;
  final bool isThreeLine;
  final Widget? thirdLine;
  final VoidCallback? onTap;

  const CustomStudentCard({
    super.key,
    this.student,
    this.studentDetail,
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
              Hero(
                tag: student ?? studentDetail!,
                child: CircleNetworkImage(
                  width: 56,
                  height: 56,
                  imgUrl: student?.profilePhoto ?? studentDetail!.profilePhoto!,
                  placeholderSize: 20,
                  errorIcon: Icons.person_rounded,
                  withBorder: hasAvatarBorder,
                  borderWidth: 2,
                  borderColor: Palette.purple80,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      student?.username ?? studentDetail!.username!,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      student?.fullName ?? studentDetail!.fullName!,
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
