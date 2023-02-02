import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetPath.getVector(
            'logo2.svg',
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        RichText(
          text: TextSpan(
            text: 'as',
            style: kTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Palette.purple100,
            ),
            children: [
              TextSpan(
                text: 'co',
                style: kTextTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Palette.purple60,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
