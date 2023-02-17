import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistant/assistant_assistance_control_card_page.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/custom_student_card.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class AssistantAssistancePractitionerPage extends StatelessWidget {
  const AssistantAssistancePractitionerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Praktikan',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          itemCount: students.length,
          itemBuilder: (_, i) => CustomStudentCard(
            student: students[i],
            isThreeLine: true,
            thirdLine: BuildBadge(
              badgeHelper: TempBadgeHelper(
                badgeId: 3,
                title: 'Kelas A',
              ),
            ),
            hasTrailing: true,
            trailing: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AssetPath.getIcons('github_filled.svg'),
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
              students[i],
            ),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}

void showAssistantAssistancePractitionerPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AssistantAssistancePractitionerPage(),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistancePractitionerPage,
      ),
    ),
  );
}
