import 'dart:async';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/presentations/widgets/input_field/field_title.dart';
import 'package:flutter/material.dart';

class InputDateField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isRequired;

  final FutureOr<void> Function(DateTime date)? action;
  const InputDateField(
      {super.key,
      required this.action,
      this.isRequired = false,
      required this.controller,
      required this.title});

  @override
  State<InputDateField> createState() => _InputDateFieldState();
}

class _InputDateFieldState extends State<InputDateField> {
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
          readOnly: true,
          onTap: () async {
            final selected = await showDatePicker(
              context: context,
              initialDate: widget.controller.text.isEmpty
                  ? DateTime.now()
                  : ReusableHelper.stringToDateTime(widget.controller.text),
              firstDate: DateTime.now().subtract(
                const Duration(days: 30),
              ),
              lastDate: DateTime.now().add(
                const Duration(
                  days: 30,
                ),
              ),
            );

            if (selected == null) return;
            setState(() {
              widget.controller.text =
                  ReusableHelper.datetimeToString(selected);
              widget.action!.call(selected);
            });
          },
          keyboardType: TextInputType.text,
          style: kTextTheme.titleSmall?.copyWith(
            color: Palette.purple80,
          ),
          cursorColor: Palette.purple80,
          decoration: InputDecoration(
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
