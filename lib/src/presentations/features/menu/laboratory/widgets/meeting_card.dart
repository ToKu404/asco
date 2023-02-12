import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/laboratory/dummy_data.dart';

class MeetingCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const MeetingCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Palette.purple100,
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
                          style: kTextTheme.titleSmall?.copyWith(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
