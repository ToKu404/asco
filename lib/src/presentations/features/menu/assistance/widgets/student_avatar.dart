import 'package:asco/src/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';

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
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Palette.white,
              child: Hero(
                tag: student!,
                child: CircleAvatar(
                  radius: 28,
                  foregroundImage: AssetImage(
                    AssetPath.getImage('avatar${1}.jpg'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              "${student?.nickName}",
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
