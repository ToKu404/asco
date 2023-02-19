import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';

class GithubDialog extends StatefulWidget {
  const GithubDialog({super.key});

  @override
  State<GithubDialog> createState() => _GithubDialogState();
}

class _GithubDialogState extends State<GithubDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 36.0,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Palette.purple100,
                    ),
                    tooltip: 'Close',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Link Repository Github',
                          textAlign: TextAlign.center,
                          style: kTextTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Palette.purple100,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Pemrograman Mobile A',
                          textAlign: TextAlign.center,
                          style: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple40,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          'Grup Asistensi 3',
                          textAlign: TextAlign.center,
                          style: kTextTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Palette.greyDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 4),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Palette.purple60,
                    ),
                    tooltip: 'Submit',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: TextField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'github.com/username/repository',
                  hintStyle: kTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Palette.greyDark.withOpacity(.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Palette.greyDark,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Palette.greyDark,
                    ),
                  ),
                ),
                style: kTextTheme.bodyLarge?.copyWith(
                  color: Palette.greyDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
