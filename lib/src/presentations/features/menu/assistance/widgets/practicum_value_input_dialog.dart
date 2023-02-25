import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';

class PracticumValueInputDialog extends StatefulWidget {
  final Student student;

  const PracticumValueInputDialog({super.key, required this.student});

  @override
  State<PracticumValueInputDialog> createState() =>
      _PracticumValueInputDialogState();
}

class _PracticumValueInputDialogState extends State<PracticumValueInputDialog> {
  final _values = <ValueType>[
    ValueType(1, 'D', Palette.red),
    ValueType(2, 'C', Palette.red),
    ValueType(3, 'B-', Palette.purple60),
    ValueType(4, 'B', Palette.purple60),
    ValueType(5, 'B+', Palette.purple60),
    ValueType(6, 'A-', Palette.purple80),
    ValueType(7, 'A', Palette.purple80),
  ];

  late final ValueNotifier<ValueType> _valueNotifier;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(_values[3]);

    super.initState();
  }

  @override
  void dispose() {
    _valueNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Palette.grey10,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 36.0,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Palette.purple100,
                    ),
                    tooltip: 'Close',
                  ),
                  Expanded(
                    child: Text(
                      'Nilai Praktikum',
                      textAlign: TextAlign.center,
                      style: kTextTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.purple100,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.check_rounded,
                      color: Palette.purple60,
                    ),
                    tooltip: 'Submit',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.student.nim,
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.student.name,
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.purple80,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (context, valueType, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RatingBar(
                            initialRating: valueType.value.toDouble(),
                            minRating: 1,
                            itemCount: 7,
                            itemSize: 36,
                            glow: false,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star_rounded,
                                color: Palette.purple80,
                              ),
                              half: const SizedBox(),
                              empty: const Icon(
                                Icons.star_border_rounded,
                                color: Palette.purple80,
                              ),
                            ),
                            onRatingUpdate: (value) {
                              final newValue = value.toInt();

                              _valueNotifier.value = _values[newValue - 1];
                            },
                          ),
                          const SizedBox(height: 12),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: valueType.color.withOpacity(.2),
                            child: Text(
                              valueType.description,
                              style: kTextTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: valueType.color,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ValueType {
  final int value;
  final String description;
  final Color color;

  ValueType(this.value, this.description, this.color);
}
