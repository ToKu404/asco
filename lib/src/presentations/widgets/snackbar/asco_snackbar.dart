import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/snackbar/content_type.dart';

class AscoSnackbar extends StatelessWidget {
  final String title;
  final String message;
  final Color? color;
  final ContentType contentType;

  const AscoSnackbar({
    Key? key,
    this.color,
    required this.title,
    required this.message,
    required this.contentType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = AppSize.getAppWidth(context);
    double height = AppSize.getAppHeight(context);

    /// For reflecting different color shades in the Snackbar
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.025,
            ),
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              title,
                              style: kTextTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Palette.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar(),
                            child: SvgPicture.asset(
                              AssetPath.getIcons('failure_outlined.svg'),
                              height: height * 0.022,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
              ),
              child: SvgPicture.asset(
                AssetPath.getVector('bubbles.svg'),
                height: height * 0.06,
                width: width * 0.05,
                color: hslDark.toColor(),
              ),
            ),
          ),
          Positioned(
            top: -height * 0.02,
            left: width * 0.02,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  AssetPath.getVector('message_bubble.svg'),
                  height: height * 0.06,
                  color: hslDark.toColor(),
                ),
                Positioned(
                  top: height * 0.015,
                  child: SvgPicture.asset(
                    assetSVG(contentType),
                    height: height * 0.022,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reflecting proper icon based on the contentType
  String assetSVG(ContentType type) {
    if (type == ContentType.success) {
      // success will show `check icon`
      return AssetPath.getIcons('success_outlined.svg');
    }

    if (type == ContentType.failure) {
      // failure will show `cross icon`
      return AssetPath.getIcons('failure_outlined.svg');
    }

    if (type == ContentType.warning) {
      // warning will show `warning icon`
      return AssetPath.getIcons('warning_outlined.svg');
    }

    if (type == ContentType.help) {
      // help will show `question icon`
      return AssetPath.getIcons('help_outlined.svg');
    }

    // the default
    return AssetPath.getIcons('success_outlined.svg');
  }
}
