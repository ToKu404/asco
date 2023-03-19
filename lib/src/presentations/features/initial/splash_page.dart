import 'dart:async';
import 'package:asco/core/constants/app_info.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/presentations/features/initial/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    // Will change page after two second
    super.didChangeDependencies();
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        showWrapper(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Palette.purple80,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                AssetPath.getVector('bg_attribute.svg'),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: RotatedBox(
                quarterTurns: -2,
                child: SvgPicture.asset(
                  AssetPath.getVector('bg_attribute.svg'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 116,
                    width: 116,
                    child: SvgPicture.asset(
                      AssetPath.getVector('logo1.svg'),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    AppInfo.appName,
                    style: TextStyle(
                      fontSize: 44,
                      fontFamily: 'OpenSans',
                      color: Palette.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
