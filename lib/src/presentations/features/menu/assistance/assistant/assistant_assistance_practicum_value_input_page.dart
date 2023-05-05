import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/src/data/datasources/const_data/score_scheme.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/practicum_value_input_dialog.dart';
import 'package:asco/src/presentations/providers/control_card_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantAssistancePracticumValueInputPage extends StatefulWidget {
  final int meetingNumber;
  final List<ProfileEntity> listStudent;

  const AssistantAssistancePracticumValueInputPage({
    super.key,
    required this.meetingNumber,
    required this.listStudent,
  });

  @override
  State<AssistantAssistancePracticumValueInputPage> createState() =>
      _AssistantAssistancePracticumValueInputPageState();
}

class _AssistantAssistancePracticumValueInputPageState
    extends State<AssistantAssistancePracticumValueInputPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<ControlCardNotifier>().fetchMultiple(
            listStudentId:
                widget.listStudent.map((e) => e.uid).toList().cast<String>(),
          );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ccNotifier = context.watch<ControlCardNotifier>();

    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Input Nilai Praktikum',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: Builder(builder: (context) {
        if (ccNotifier.isLoadingState('multiple')) {
          return const AscoLoading();
        }

        if (ccNotifier.isErrorState('multiple')) {
          return Center(
            child: Text(ccNotifier.message),
          );
        }

        final controlCardResultEntity = ccNotifier.listData;

        return ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          itemCount: widget.listStudent.length,
          itemBuilder: (_, i) => PracticumValueCard(
            student: widget.listStudent[i],
            meetingNumber: widget.meetingNumber,
            cardResultEntity: controlCardResultEntity.firstWhere(
              (element) => element.studentId == widget.listStudent[i].uid,
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 16),
        );
      }),
    );
  }
}

class PracticumValueCard extends StatelessWidget {
  final int meetingNumber;
  final ControlCardResultEntity cardResultEntity;
  final ProfileEntity student;

  const PracticumValueCard({
    super.key,
    required this.student,
    required this.cardResultEntity,
    required this.meetingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      radius: 12,
      color: Palette.white,
      padding: const EdgeInsets.all(16),
      border: Border.all(color: Palette.purple80),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          offset: Offset(3, 4),
          color: Palette.purple80,
        ),
      ],
      onTap: () => showDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: false,
        builder: (_) => PracticumValueInputDialog(
          student: student,
          meetingNumber: meetingNumber,
          controlCardResult: cardResultEntity,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 24,
                backgroundColor: Palette.purple80,
                child: CircleAvatar(
                  radius: 22,
                  foregroundImage: AssetImage(
                    AssetPath.getImage('avatar1.jpg'),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      student.username ?? '',
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      student.fullName ?? '',
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.purple80,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Builder(builder: (context) {
            ValueType? val =
                cardResultEntity.data![meetingNumber - 1].star != null
                    ? ScoreScheme.valuesScheme[
                        cardResultEntity.data![meetingNumber - 1].star! - 1]
                    : null;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const PracticumBadge(
                        badgeTitle: 'Waktu asistensi',
                        badgeContent: 'Tepat waktu',
                        badgeColor: Palette.purple60,
                      ),
                      const SizedBox(height: 8),
                      if (val != null)
                        PracticumBadge(
                          badgeTitle: 'Nilai asistensi',
                          badgeContent: val.descScore,
                          badgeColor: Palette.red,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  curve: Curves.easeOut,
                  reverse: true,
                  radius: 45,
                  lineWidth: 10,
                  percent: val != null ? val.score / 100 : 1,
                  progressColor: Palette.purple60,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Container(
                    width: 90,
                    height: 90,
                    margin: const EdgeInsets.all(9),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.purple80,
                    ),
                    child: Center(
                      child: Text(
                        val != null ? val.score.toStringAsFixed(1) : '-',
                        style: kTextTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Palette.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class PracticumBadge extends StatelessWidget {
  final String badgeTitle;
  final String badgeContent;
  final Color badgeColor;

  const PracticumBadge({
    super.key,
    required this.badgeTitle,
    required this.badgeContent,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            badgeTitle,
            style: kTextTheme.bodyMedium?.copyWith(
              color: Palette.purple80,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: badgeColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            badgeContent,
            style: kTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: badgeColor,
            ),
          ),
        ),
      ],
    );
  }
}

void showAssistantAssistancePracticumValueInputPage(
  BuildContext context, {
  required int meetingNumber,
  required List<ProfileEntity> listStudent,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantAssistancePracticumValueInputPage(
        meetingNumber: meetingNumber,
        listStudent: listStudent,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistancePracticumValueInputPage,
      ),
    ),
  );
}
