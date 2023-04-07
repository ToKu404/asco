import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistant/assistant_assistance_control_card_page.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/custom_student_card.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantAssistancePractitionerPage extends StatefulWidget {
  final String practicumId;

  const AssistantAssistancePractitionerPage({
    super.key,
    required this.practicumId,
  });

  @override
  State<AssistantAssistancePractitionerPage> createState() =>
      _AssistantAssistancePractitionerPageState();
}

class _AssistantAssistancePractitionerPageState
    extends State<AssistantAssistancePractitionerPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false)
          .fetchAll(practicumUid: widget.practicumId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, profileNotifier, child) {
        if (profileNotifier.isSuccessState('find')) {
          final students = profileNotifier.listData
              .where((e) => e.userRole!.id == 1)
              .toList();

          final classCodes = students.map((detailProfile) {
            final key = detailProfile.userPracticums!.keys
                .where((e) => e == widget.practicumId)
                .first;

            return detailProfile.userPracticums![key]!.classroom!.classCode;
          }).toList();

          return buildMainPage(
            context,
            students: students,
            classCodes: classCodes,
          );
        }

        if (profileNotifier.isErrorState('find')) {
          return const Scaffold(
            backgroundColor: Palette.grey,
            body: Center(
              child: Text('unknown error occured'),
            ),
          );
        }

        return const AscoLoading(
          withScaffold: true,
        );
      },
    );
  }

  Scaffold buildMainPage(
    BuildContext context, {
    required List<DetailProfileEntity> students,
    required List<String?> classCodes,
  }) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Praktikan',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 16,
        ),
        itemCount: students.length,
        itemBuilder: (_, index) => CustomStudentCard(
          studentDetail: students[index],
          isThreeLine: true,
          thirdLine: BuildBadge(
            badgeHelper: TempBadgeHelper(
              badgeId: 3,
              title: 'Kelas ${classCodes[index]}',
            ),
          ),
          hasTrailing: true,
          trailing: IconButton(
            onPressed: () {
              ReusableHelper.onPressedSocialMediaIcon(
                context,
                isAvailable: students[index].github!.isNotEmpty,
                uri: students[index].github!,
                socialMedia: 'Github',
              );
            },
            icon: SvgPicture.asset(
              AssetPath.getIcon('github_filled.svg'),
              color: Palette.purple80,
              width: 24,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Palette.grey10,
            ),
            tooltip: 'Github',
          ),
          onTap: () => showAssistantAssistanceControlCardPage(
            context,
            practicumId: widget.practicumId,
            student: students[index],
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
    );
  }
}

void showAssistantAssistancePractitionerPage(
  BuildContext context, {
  required String practicumId,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantAssistancePractitionerPage(
        practicumId: practicumId,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistancePractitionerPage,
      ),
    ),
  );
}
