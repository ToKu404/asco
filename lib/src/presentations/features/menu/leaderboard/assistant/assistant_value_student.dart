import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/assistant/assistant_value_recap.dart';
import 'package:asco/src/presentations/widgets/avatar.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:super_banners/super_banners.dart';

class AssistantValueStudent extends StatelessWidget {
  final List<ProfileEntity> students;
  final List<ScoreEntity> scores;
  const AssistantValueStudent(
      {super.key, required this.students, required this.scores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Nilai Praktikan',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView.separated(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: false),
            itemBuilder: (context, index) {
              final scoreStudent = scores
                  .where((element) => element.studentId == students[index].uid);
              return StudentScoreCard(
                profileEntity: students[index],
                scoreEntity: scoreStudent.isEmpty ? null : scoreStudent.first,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: students.length,
          ),
        ),
      ),
    );
  }
}

class StudentScoreCard extends StatelessWidget {
  final ProfileEntity profileEntity;
  final ScoreEntity? scoreEntity;
  const StudentScoreCard({
    super.key,
    required this.profileEntity,
    this.scoreEntity,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          InkWellContainer(
            color: Palette.white,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AssistantValueRecap(),
                settings: const RouteSettings(
                  name: AppRoute.assistantValueRecapLeaderboardPage,
                ),
              ),
            ),
            padding: const EdgeInsets.all(8),
            radius: 12,
            child: ListTile(
              leading: const Avatar(
                imageAsset: 'avatar1.jpg',
                radius: 28,
                color: Palette.white,
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      profileEntity.username!,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      profileEntity.nickName!,
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  //   Container(
                  //     decoration: BoxDecoration(
                  //       color: Palette.purple60,
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     padding:
                  //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //     child: Text(
                  //       'Kelas ${profileEntity.}',
                  //       style: kTextTheme.bodySmall?.copyWith(
                  //         color: Palette.white,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              trailing: Text(
                '${scoreEntity == null ? '-' : scoreEntity!.recapScore}',
                style: kTextTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: CornerBanner(
              bannerColor: Palette.yellow,
              bannerPosition: CornerBannerPosition.topRight,
              elevation: 0,
              child: Text(
                'No 2',
                style: kTextTheme.bodyMedium?.copyWith(color: Palette.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
