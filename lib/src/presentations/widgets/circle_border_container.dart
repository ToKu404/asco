import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';

class CircleBorderContainer extends StatelessWidget {
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final Color? fillColor;
  final Widget? child;
  final VoidCallback? onTap;

  const CircleBorderContainer({
    super.key,
    required this.size,
    this.borderColor,
    this.borderWidth = 1.0,
    this.fillColor,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fillColor ?? Palette.grey,
        shape: BoxShape.circle,
        border: Border.all(
          width: borderWidth,
          color: borderColor ?? Palette.greyDark,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size / 2),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
