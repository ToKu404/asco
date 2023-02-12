import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';

class PurpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback? onPressedBackButton;
  final List<Widget>? actions;

  const PurpleAppBar({
    super.key,
    this.titleText = '',
    this.onPressedBackButton,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Palette.purple80,
      surfaceTintColor: Colors.transparent,
      title: Text(titleText),
      centerTitle: true,
      titleTextStyle: kTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: Palette.white,
      ),
      leading: IconButton(
        onPressed: onPressedBackButton,
        icon: const Icon(
          Icons.chevron_left_rounded,
          size: 36,
          color: Palette.white,
        ),
        tooltip: 'Back',
      ),
      actions: actions,
    );
  }
}
