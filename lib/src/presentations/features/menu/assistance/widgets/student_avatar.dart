import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';

class StudentAvatar extends StatelessWidget {
  final ProfileEntity? student;
  final VoidCallback? onTap;

  const StudentAvatar({
    super.key,
    required this.student,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Hero(
              tag: student ?? '',
              child: CircleNetworkImage(
                width: 60,
                height: 60,
                imgUrl: student?.profilePhoto ?? '',
                placeholderSize: 24,
                errorIcon: Icons.person_rounded,
                withBorder: true,
                borderWidth: 2,
                borderColor: Palette.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              '${student?.nickName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: kTextTheme.bodySmall?.copyWith(
                color: Palette.purple100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
