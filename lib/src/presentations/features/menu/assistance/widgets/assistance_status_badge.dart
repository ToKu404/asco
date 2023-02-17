import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';

class AssistanceStatusBadge extends StatelessWidget {
  final Course course;

  const AssistanceStatusBadge({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (course.isLocked) ...[
          const CircleBorderContainer(size: 30),
          const SizedBox(width: 4),
          const CircleBorderContainer(size: 30),
        ] else ...[
          const CircleBorderContainer(
            size: 30,
            borderColor: Palette.purple80,
            fillColor: Palette.purple60,
            child: Icon(
              Icons.check_rounded,
              size: 16,
              color: Palette.white,
            ),
          ),
          const SizedBox(width: 4),
          const CircleBorderContainer(
            size: 30,
            borderColor: Color(0xFFD35380),
            fillColor: Color(0xFFFA78A6),
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: Palette.white,
            ),
          ),
        ],
      ],
    );
  }
}
