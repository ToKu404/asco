import 'package:flutter/material.dart';

class InkWellContainer extends StatelessWidget {
  final double radius;
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final BoxBorder? border;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const InkWellContainer({
    super.key,
    this.radius = 0,
    required this.color,
    required this.onTap,
    required this.child,
    this.padding,
    this.border,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
        border: border,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
