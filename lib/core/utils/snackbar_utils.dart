import 'package:flutter/material.dart';
import 'package:asco/src/presentations/widgets/snackbar/asco_snackbar.dart';
import 'package:asco/src/presentations/widgets/snackbar/content_type.dart';

class SnackbarUtils {
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
  }) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: AscoSnackbar(
        title: title,
        message: message,
        contentType: type ?? ContentType.success,
      ),
    );
  }
}
