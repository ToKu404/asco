// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/widgets.dart';

class AppSize {
  static double getAppWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getAppHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
