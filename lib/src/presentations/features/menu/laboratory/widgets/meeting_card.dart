import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';

class MeetingCard extends StatelessWidget {
  final Course course;
  final double paddingBottom;
  final bool isThreeLine;
  final Widget? thirdLine;
  final VoidCallback? onTap;

  const MeetingCard({
    super.key,
    required this.course,
    this.paddingBottom = 10,
    this.isThreeLine = false,
    this.thirdLine,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Palette.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Palette.purple80,
                  child: Text(
                    '#${course.number}',
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.white,
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
                        course.topic,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.purple100,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.purple60,
                        ),
                      ),
                      if (isThreeLine) ...[
                        const SizedBox(height: 4),
                        thirdLine!,
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
