import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  const InputTextField(
      {super.key, required this.controller, required this.title});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.black,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
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
