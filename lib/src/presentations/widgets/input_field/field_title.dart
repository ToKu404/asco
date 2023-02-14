import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

class RequiredFieldTitle extends StatelessWidget {
  final String title;
  const RequiredFieldTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: ' *',
                style: kTextTheme.titleSmall?.copyWith(
                  color: Colors.red,
                ),
              )
            ],
            text: title,
            style: kTextTheme.titleSmall?.copyWith(
              color: Palette.black,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}

class FieldTitle extends StatelessWidget {
  final String title;
  const FieldTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.black,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
