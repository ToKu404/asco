import 'package:flutter/material.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/meeting_card.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantLaboratorySchedulePage extends StatelessWidget {
  final List<Map<int, DetailMeetingEntity>> listMeetingMap;

  const AssistantLaboratorySchedulePage({
    super.key,
    required this.listMeetingMap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Jadwal Asisten',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: listMeetingMap.isEmpty
          ? const Center(
              child: Text('Anda tidak memiliki jadwal pertemuan.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 14),
              itemCount: listMeetingMap.length,
              itemBuilder: (_, i) => MeetingCard(
                meeting: listMeetingMap[i].values.first,
                isThreeLine: true,
                thirdLine: listMeetingMap[i].keys.first == 0
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

void showAssistantLaboratorySchedulePage(
  BuildContext context, {
  required List<Map<int, DetailMeetingEntity>> listMeetingMap,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantLaboratorySchedulePage(
        listMeetingMap: listMeetingMap,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantLaboratorySchedulePage,
      ),
    ),
  );
}
