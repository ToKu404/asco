import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/input_field/field_title.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isRequired;
  const InputTextField(
      {super.key,
      required this.controller,
      required this.title,
      this.isRequired = false});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired
            ? RequiredFieldTitle(title: widget.title)
            : FieldTitle(title: widget.title),
        TextField(
          controller: widget.controller,
          onChanged: (value) {},
          keyboardType: TextInputType.text,
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.purple80,
          ),
          cursorColor: Palette.purple80,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
    );
  }
}
