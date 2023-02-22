import 'package:flutter/material.dart';
import 'package:asco/src/presentations/widgets/snack_bar/asco_snack_bar.dart';
import 'package:asco/src/presentations/widgets/snack_bar/content_type.dart';

class SnackBarUtils {
  /// Create custom asco snackbar.
  ///
  /// - [title] The title of snackbar. Basically it only contains 1 to 3 words.
  ///
  /// - [message] The message of snackbar. Will be displayed under the title.
  ///
  /// - [type] The type of snackbar. default to `ContentType.success`
  ///
  /// Its only create snackbar, not showing it. For showing snackbar, simply use:
  /// `ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackbar);`
  static SnackBar createSnackBar({
    required String title,
    required String message,
    ContentType? type,
    Color? color,
  }) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: AscoSnackBar(
        title: title,
        message: message,
        contentType: type ?? ContentType.success,
        color: color,
      ),
    );
  }
}
