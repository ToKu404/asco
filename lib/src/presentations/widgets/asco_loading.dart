import 'package:asco/core/constants/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AscoLoading extends StatelessWidget {
  final bool withScaffold;
  const AscoLoading({super.key, this.withScaffold = false});

  @override
  Widget build(BuildContext context) {
    return withScaffold
        ? Scaffold(
            body: content(),
            backgroundColor: Palette.grey,
          )
        : content();
  }

  Center content() {
    return const Center(
      child: SpinKitCubeGrid(
        color: Palette.purple80,
        size: 50.0,
      ),
    );
  }
}
