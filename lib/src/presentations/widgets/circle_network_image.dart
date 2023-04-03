import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:asco/core/constants/color_const.dart';

class CircleNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final String imgUrl;
  final double placeholderSize;
  final IconData errorIcon;
  final bool withBorder;
  final double? borderWidth;
  final Color? borderColor;

  const CircleNetworkImage({
    Key? key,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    required this.imgUrl,
    required this.placeholderSize,
    required this.errorIcon,
    this.withBorder = false,
    this.borderWidth,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fadeInDuration: const Duration(milliseconds: 250),
      fadeOutDuration: const Duration(milliseconds: 250),
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: withBorder
                ? Border.all(
                    width: borderWidth ?? 1,
                    color: borderColor ?? const Color(0xFF000000),
                  )
                : null,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return CircleAvatar(
          radius: width / 2,
          backgroundColor: Palette.white,
          child: Center(
            child: SizedBox(
              width: placeholderSize,
              height: placeholderSize,
              child: const SpinKitRing(
                lineWidth: 3,
                color: Palette.disable,
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return CircleAvatar(
          radius: width / 2,
          backgroundColor: Palette.white,
          child: Center(
            child: Icon(
              errorIcon,
              color: Palette.disable,
            ),
          ),
        );
      },
    );
  }
}
