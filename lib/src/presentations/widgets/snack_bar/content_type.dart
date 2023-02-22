import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';

class ContentType {
  final String message;
  final Color? color;

  ContentType(this.message, [this.color]);

  static ContentType help = ContentType('help', Palette.azure60);
  static ContentType failure = ContentType('failure', Palette.plum60);
  static ContentType success = ContentType('success', Palette.purple60);
  static ContentType warning = ContentType('warning', Palette.orange60);
}
