import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';

class ControlCard extends StatelessWidget {
  final MeetingEntity? meeting;
  final bool hasTrailing;
  final Widget? trailing;
  final bool isThreeLine;
  final Widget? thirdLine;
  final CrossAxisAlignment verticalAlignment;
  final VoidCallback? onTap;

  const ControlCard({
    super.key,
    required this.meeting,
    this.hasTrailing = false,
    this.trailing,
    this.isThreeLine = false,
    this.thirdLine,
    this.verticalAlignment = CrossAxisAlignment.center,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Palette.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
              crossAxisAlignment: verticalAlignment,
              children: <Widget>[
                CircleBorderContainer(
                  size: 50,
                  borderWidth: 1.5,
                  child: Text(
                    '${meeting?.meetingNumber}',
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.greyDark,
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
                        meeting?.topic ?? '',
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
                        meeting!.meetingDate != null
                            ? ReusableHelper.dateTimeToString(
                                meeting!.meetingDate!,
                              )
                            : '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.purple60,
                        ),
                      ),
                      if (isThreeLine) ...[
                        const SizedBox(height: 10),
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
      ),
    );
  }
}
