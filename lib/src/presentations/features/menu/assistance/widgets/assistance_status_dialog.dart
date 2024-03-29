import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';

class AssistanceStatusDialog extends StatelessWidget {
  final int number;
  final ProfileEntity student;

  const AssistanceStatusDialog({
    super.key,
    required this.number,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = number == 1; // for testing purpose only

    return Dialog(
      elevation: 0,
      backgroundColor: Palette.grey10,
      insetPadding: const EdgeInsets.fromLTRB(36, 56, 36, 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: -130,
            child: SizedBox(
              width: 250,
              height: 250,
              child: RiveAnimation.asset(
                AssetPath.getRive(
                  isDone ? 'checkmark_icon.riv' : 'error_icon.riv',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 72, 18, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Tipe Data dan Attribute',
                  textAlign: TextAlign.center,
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple100,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Asistensi $number',
                  textAlign: TextAlign.center,
                  style: kTextTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Palette.purple80,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Status ',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple100,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: isDone ? 'Selesai' : 'Belum selesai',
                        style: kTextTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDone ? Palette.purple60 : Palette.plum60,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  '${student.fullName}',
                  textAlign: TextAlign.center,
                  style: kTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Palette.purple80,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${student.username}',
                  textAlign: TextAlign.center,
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple100,
                  ),
                ),
                Text(
                  '27/11/2022',
                  textAlign: TextAlign.center,
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
