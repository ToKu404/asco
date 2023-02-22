import 'package:flutter/material.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/meeting_card.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantLaboratorySchedulePage extends StatelessWidget {
  const AssistantLaboratorySchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Jadwal Asisten',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 14),
        itemCount: courses.length,
        itemBuilder: (_, i) => MeetingCard(
          course: courses[i],
          isThreeLine: true,
          thirdLine: i.isEven
              ? BuildBadge(
                  badgeHelper: TempBadgeHelper(
                    badgeId: 2,
                    title: 'Pemateri',
                  ),
                )
              : BuildBadge(
                  badgeHelper: TempBadgeHelper(
                    badgeId: 4,
                    title: 'Pendamping',
                  ),
                ),
        ),
      ),
    );
  }
}

void showAssistantLaboratorySchedulePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AssistantLaboratorySchedulePage(),
      settings: const RouteSettings(
        name: AppRoute.assistantLaboratorySchedulePage,
      ),
    ),
  );
}
