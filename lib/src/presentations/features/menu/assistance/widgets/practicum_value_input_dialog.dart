import 'package:asco/src/data/datasources/const_data/score_scheme.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/providers/score_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:provider/provider.dart';

import '../../../../../data/datasources/helpers/update_data_helper.dart';
import '../../../../providers/control_card_notifier.dart';

class PracticumValueInputDialog extends StatefulWidget {
  final ProfileEntity student;
  final ControlCardResultEntity controlCardResultEntity;
  final int meetingNumber;

  const PracticumValueInputDialog({
    super.key,
    required this.student,
    required this.controlCardResultEntity,
    required this.meetingNumber,
  });

  @override
  State<PracticumValueInputDialog> createState() =>
      _PracticumValueInputDialogState();
}

class _PracticumValueInputDialogState extends State<PracticumValueInputDialog> {
  late final ValueNotifier<ValueType> _valueNotifier;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(ScoreScheme.valuesScheme[widget
                .controlCardResultEntity.data![widget.meetingNumber - 1].star !=
            null
        ? widget.controlCardResultEntity.data![widget.meetingNumber - 1].star! -
            1
        : 3]);
    Future.microtask(() => context.read<ScoreNotifier>()
      ..fetchMultiple(listStudentId: [widget.student.uid!]));

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
                  Builder(builder: (context) {
                    final notifier = context.watch<ScoreNotifier>();
                    if (notifier.isSuccessState('multiple')) {
                      return IconButton(
                        onPressed: () {
                          final result = UpdateDataHelper.updateControlCard(
                            ccEntityList: widget.controlCardResultEntity.data!,
                            newCC: ControlCardEntity(
                              star: _valueNotifier.value.value,
                            ),
                            meetingNumber: widget.meetingNumber,
                          );
                          if (notifier.listData.isNotEmpty) {
                            double sum = 0;
                            int count = 0;

                            for (int i = 0; i < result.length; i++) {
                              if (result[i].star != null) {
                                sum += ScoreScheme.valuesScheme
                                    .firstWhere((element) =>
                                        element.value == result[i].star!)
                                    .score;
                              }
                              count++;
                            }

                            double avgScore = count > 0 ? sum / count : 0;
                            final score = UpdateDataHelper.updateScore(
                              updateScoreType: UpdateScoreType.assistance,
                              scoreEntity: notifier.listData.first,
                              newScore: avgScore,
                            );
                            context
                                .read<ScoreNotifier>()
                                .update(uid: widget.student.uid!, score: score);
                          }

                          context
                              .read<ControlCardNotifier>()
                              .updateControlCard(
                                  uid: widget.controlCardResultEntity.uid!,
                                  listCC: result)
                              .then((value) => Navigator.pop(context));
                        },
                        icon: const Icon(
                          Icons.check_rounded,
                          color: Palette.purple60,
                        ),
                        tooltip: 'Submit',
                      );
                    }
                    return const SizedBox.shrink();
                  }),
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
                    widget.student.username!,
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.student.fullName ?? '',
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

                              _valueNotifier.value =
                                  ScoreScheme.valuesScheme[newValue - 1];
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
  final int score;
  final String descScore;

  ValueType(
    this.value,
    this.description,
    this.color,
    this.score,
    this.descScore,
  );
}
