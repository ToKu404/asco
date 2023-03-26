import 'dart:async';
import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/time_helper.dart';
import 'package:asco/src/presentations/widgets/input_field/field_title.dart';

class InputTimeField extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController? controller2;
  final String title;
  final bool isRequired;
  final bool withEndTime;
  final FutureOr<void> Function(TimeHelper time)? action;

  const InputTimeField({
    super.key,
    required this.controller1,
    required this.title,
    this.controller2,
    this.withEndTime = false,
    this.isRequired = false,
    required this.action,
  });

  @override
  State<InputTimeField> createState() => _InputTimeFieldState();
}

class _InputTimeFieldState extends State<InputTimeField> {
  final TimeHelper th = TimeHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isRequired
            ? RequiredFieldTitle(title: widget.title)
            : FieldTitle(title: widget.title),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (!widget.isRequired) {
                    return null;
                  } else {
                    if (value!.isEmpty) {
                      return 'Field wajib diisi';
                    }
                  }
                  return null;
                },
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  );
                  if (time == null) return;
                  setState(() {
                    th.setStartTime(
                        startHour: time.hour, startMinute: time.minute);
                    widget.controller1.text = '${time.hour}:${time.minute}';
                    if (!widget.withEndTime || th.endHour != null) {
                      widget.action!.call(th);
                    }
                  });
                },
                controller: widget.controller1,
                readOnly: true,
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
            ),
            if (widget.controller2 != null) ...[
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (!widget.isRequired) {
                      return null;
                    } else {
                      if (value!.isEmpty) {
                        return 'Field wajib diisi';
                      }
                    }
                    return null;
                  },
                  controller: widget.controller2,
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
                    if (time == null) return;
                    setState(() {
                      th.setEndTime(endHour: time.hour, endMinute: time.minute);
                      widget.controller2?.text = '${time.hour}:${time.minute}';
                      if (th.startHour != null) {
                        widget.action?.call(th);
                      }
                    });
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  style: kTextTheme.titleSmall?.copyWith(
                    color: Palette.purple80,
                  ),
                  cursorColor: Palette.purple80,
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
              ),
            ],
          ],
        ),
      ],
    );
  }
}
