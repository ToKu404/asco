import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/presentations/widgets/input_field/field_title.dart';
import 'package:asco/src/presentations/widgets/input_field/input_text_field.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:flutter/material.dart';

class EditInfoPage extends StatelessWidget {
  const EditInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Edit Info',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputTextField(
              controller: TextEditingController(),
              title: 'Judul',
            ),
            const SizedBox(height: 28),
            InputTextField(
              controller: TextEditingController(),
              title: 'Sub Judul 1',
            ),
            const SizedBox(height: 28),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FieldTitle(title: 'Deskripsi'),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.blackPurple),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.purple80),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
