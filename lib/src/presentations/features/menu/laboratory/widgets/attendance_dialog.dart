import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';

class AttendanceDialog extends StatefulWidget {
  final Student student;

  const AttendanceDialog({super.key, required this.student});

  @override
  State<AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  late final ValueNotifier<FaceStatus?> statusNotifier;

  @override
  void initState() {
    statusNotifier = ValueNotifier(null);

    super.initState();
  }

  @override
  void dispose() {
    statusNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 36.0,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Palette.purple100,
                    ),
                    tooltip: 'Back',
                  ),
                  Text(
                    'Absensi',
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.purple100,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Palette.purple60,
                    ),
                    tooltip: 'Submit',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.student.nim,
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.student.name,
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.purple80,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: statusNotifier,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: listStatus
                            .map(
                              (status) => FaceStatusWidget(
                                status: status,
                                isSelected: value == status,
                                onTap: () => statusNotifier.value = status,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FaceStatusWidget extends StatelessWidget {
  final FaceStatus status;
  final VoidCallback? onTap;
  final bool isSelected;

  const FaceStatusWidget({
    super.key,
    required this.status,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Palette.grey10,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? status.borderColor : Palette.grey10,
            ),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                AssetPath.getIcons(status.iconName),
                color: isSelected ? status.borderColor : Palette.grey50,
                width: 30,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          status.status,
          style: kTextTheme.bodyMedium?.copyWith(
            color: isSelected ? status.borderColor : Palette.grey50,
          ),
        ),
      ],
    );
  }
}
