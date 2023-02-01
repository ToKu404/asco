import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackgroundContainer extends StatelessWidget {
  final Widget modal;
  const BlurBackgroundContainer({Key? key, required this.modal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: modal,
    );
  }
}
