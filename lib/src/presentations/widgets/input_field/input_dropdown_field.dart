import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

class InputDropdownField extends StatefulWidget {
  final ValueNotifier<String?> selectItem;
  final String title;
  final List<String> listItem;
  const InputDropdownField(
      {super.key,
      required this.selectItem,
      required this.title,
      required this.listItem});

  @override
  State<InputDropdownField> createState() => _InputDropdownFieldState();
}

class _InputDropdownFieldState extends State<InputDropdownField> {
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
        ValueListenableBuilder(
            valueListenable: widget.selectItem,
            builder: (context, value, _) {
              return DropdownButtonFormField<String>(
                value: value,
                items: widget.listItem.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
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
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                onChanged: (value) {
                  widget.selectItem.value = value.toString();
                },
                style: kTextTheme.titleSmall?.copyWith(
                  color: Palette.purple80,
                ),
              );
            })

        // DropdownButtonFormField(
        //
        //     items: widget.listItem
        //         .map(
        //           (item) => DropdownMenuItem(
        //             value: widget.listItem,
        //             child: Text(item),
        //           ),
        //         )
        //         .toList(),
        //     borderRadius: BorderRadius.circular(12.0),
        //
        //     isExpanded: false,
        //     decoration: InputDecoration(
        //       contentPadding:
        //           const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        //       filled: true,
        //       fillColor: Colors.white,
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: const BorderSide(color: Palette.blackPurple),
        //         borderRadius: BorderRadius.circular(12.0),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderSide: const BorderSide(color: Palette.purple80),
        //         borderRadius: BorderRadius.circular(12.0),
        //       ),
        //     ),
        //     value: selectedValue,
        //     onChanged: (value) {
        //       setState(() {
        //         selectedValue = value.toString();
        //       });
        //     }),
      ],
    );
  }
}
