import 'package:flutter/material.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';

class StudentAvatar extends StatelessWidget {
  final Student student;

  const StudentAvatar({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: Palette.white,
            child: CircleAvatar(
              radius: 28,
              foregroundImage: AssetImage(
                AssetPath.getImage('avatar${student.id}.jpg'),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              student.name,
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
