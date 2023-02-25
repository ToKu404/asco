import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/practicum_value_input_dialog.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantAssistancePracticumValueInputPage extends StatelessWidget {
  const AssistantAssistancePracticumValueInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Input Nilai Praktikum',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        itemCount: students.length,
        itemBuilder: (_, i) => PracticumValueCard(student: students[i]),
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      ),
    );
  }
}

class PracticumValueCard extends StatelessWidget {
  final Student student;

  const PracticumValueCard({super.key, required this.student});

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
        builder: (_) => PracticumValueInputDialog(student: student),
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
                    AssetPath.getImage('avatar${student.id}.jpg'),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      student.nim,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      student.name,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    PracticumBadge(
                      badgeTitle: 'Waktu asistensi',
                      badgeContent: 'Tepat waktu',
                      badgeColor: Palette.purple60,
                    ),
                    SizedBox(height: 8),
                    PracticumBadge(
                      badgeTitle: 'Nilai asistensi',
                      badgeContent: 'Kurang bagus',
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
                percent: .75,
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
                      '75.0',
                      style: kTextTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

void showAssistantAssistancePracticumValueInputPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AssistantAssistancePracticumValueInputPage(),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistancePracticumValueInputPage,
      ),
    ),
  );
}
