import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:asco/core/constants/color_const.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final String imgUrl;
  final double placeholderSize;
  final IconData errorIcon;

  const CustomNetworkImage({
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    required this.imgUrl,
    required this.placeholderSize,
    required this.errorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 250),
      fadeOutDuration: const Duration(milliseconds: 250),
      placeholder: (context, url) {
        return Container(
          width: width,
          height: height,
          color: Palette.white,
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
        return Container(
          width: width,
          height: height,
          color: Palette.white,
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
