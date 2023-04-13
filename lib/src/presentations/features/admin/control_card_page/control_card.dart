import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/helpers.dart';
import 'package:asco/src/domain/entities/assistance_entities/control_card_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';

class ControlCard extends StatelessWidget {
  final ControlCardEntity controlCardEntity;
  final MeetingEntity? meetingEntity;
  final bool hasTrailing;
  final Widget? trailing;
  final bool isThreeLine;
  final Widget? thirdLine;
  final CrossAxisAlignment verticalAlignment;
  final VoidCallback? onTap;

  const ControlCard({
    super.key,
    required this.controlCardEntity,
    this.hasTrailing = false,
    this.trailing,
    this.isThreeLine = false,
    this.thirdLine,
    this.meetingEntity,
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
                  child: meetingEntity == null
                      ? const Icon(
                          Icons.lock_outline_rounded,
                          color: Palette.greyDark,
                          size: 20,
                        )
                      : Text(
                          '${1}',
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
                        meetingEntity == null
                            ? "-"
                            : meetingEntity!.topic ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: meetingEntity == null
                              ? Palette.greyDark
                              : Palette.purple100,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meetingEntity == null
                            ? "-"
                            : ReusableHelper.dateTimeToString(
                                meetingEntity!.meetingDate!),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: meetingEntity == null
                              ? Palette.grey50
                              : Palette.purple60,
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

class AssistanceStatusBadge extends StatelessWidget {
  const AssistanceStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        CircleBorderContainer(size: 30),
        SizedBox(width: 4),
        CircleBorderContainer(size: 30),

        // const CircleBorderContainer(
        //   size: 30,
        //   borderColor: Palette.purple80,
        //   fillColor: Palette.purple60,
        //   child: Icon(
        //     Icons.check_rounded,
        //     size: 16,
        //     color: Palette.white,
        //   ),
        // ),
        // const SizedBox(width: 4),
        // const CircleBorderContainer(
        //   size: 30,
        //   borderColor: Color(0xFFD35380),
        //   fillColor: Color(0xFFFA78A6),
        //   child: Icon(
        //     Icons.close_rounded,
        //     size: 16,
        //     color: Palette.white,
        //   ),
        // ),
      ],
    );
  }
}
