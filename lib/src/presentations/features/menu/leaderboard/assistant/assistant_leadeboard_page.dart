import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/domain/entities/entities.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/assistant/assistant_value_recap.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/assistant/assistant_value_student.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/providers/score_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AssistantLeaderboardPage extends StatefulWidget {
  final String practicumUid;
  final String groupId;
  const AssistantLeaderboardPage(
      {super.key, required this.practicumUid, required this.groupId});

  @override
  State<AssistantLeaderboardPage> createState() =>
      _AssistantLeaderboardPageState();
}

class _AssistantLeaderboardPageState extends State<AssistantLeaderboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<ProfileNotifier>(context, listen: false)
            .fetchAll(practicumUid: widget.practicumUid);
        Provider.of<AssistanceNotifier>(context, listen: false)
            .getDetail(uuid: widget.groupId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.purple80,
      body: Builder(
        builder: (context) {
          final profileNotifier = context.watch<ProfileNotifier>();
          final assistanceNo = context.watch<AssistanceNotifier>();

          if (profileNotifier.isSuccessState('find') &&
              assistanceNo.isSuccessState('single')) {
            return _BuildLeaderBoard(
              students: profileNotifier.listData,
              assistStudents: assistanceNo.data!.students!,
            );
          }
          return const AscoLoading();
        },
      ),
    );
  }
}

class _BuildLeaderBoard extends StatefulWidget {
  final List<ProfileEntity> assistStudents;
  final List<DetailProfileEntity> students;
  const _BuildLeaderBoard(
      {required this.students, required this.assistStudents});

  @override
  State<_BuildLeaderBoard> createState() => _BuildLeaderBoardState();
}

class _BuildLeaderBoardState extends State<_BuildLeaderBoard> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ScoreNotifier>().fetchMultiple(
          listStudentId: widget.students.map((e) => e.uid!).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    final scoreNotifier = context.watch<ScoreNotifier>();
    if (scoreNotifier.isLoadingState('multiple')) {
      return const AscoLoading();
    }
    if (scoreNotifier.isErrorState('multiple')) {
      return Text(scoreNotifier.message);
    }

    final sortedData = scoreNotifier.listData;
    sortedData.sort((a, b) => a.recapScore!.compareTo(b.recapScore!));

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              'Leaderboard',
              style: kTextTheme.headlineMedium?.copyWith(
                color: Palette.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssistantValueStudent(
                  students: widget.assistStudents,
                  scores: sortedData,
                ),
                settings: const RouteSettings(
                  name: AppRoute.assistantValueRecapLeaderboardPage,
                ),
              ),
            ),
            child: LeaderboardCard(
              students: widget.assistStudents,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Palette.purple100,
                borderRadius: BorderRadius.circular(24),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Text(
                'Rekap',
                style: kTextTheme.bodyMedium?.copyWith(
                  color: Palette.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Leaderboard(
            scores: sortedData,
            profileEntity: widget.students,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Palette.grey10,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (context, index) {
                if (index + 3 < sortedData.length) {
                  ProfileEntity? current;
                  for (int i = 0; i < widget.students.length; i++) {
                    if (sortedData[index + 3].studentId ==
                        widget.students[i].uid) {
                      current = ProfileEntity.fromDetail(widget.students[i]);
                    }
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: CardTile(
                      position: index + 4,
                      scoreEntity: sortedData[index + 3],
                      student: current!,
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: Palette.grey10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    height: 85,
                  );
                }
              },
              itemCount: sortedData.length > 6
                  ? sortedData.length > 10
                      ? 7
                      : sortedData.length - 3
                  : 3,
            ),
          )
        ],
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final ProfileEntity student;
  final ScoreEntity scoreEntity;
  final int position;

  const CardTile({
    super.key,
    required this.student,
    required this.scoreEntity,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: AssetImage(
          AssetPath.getImage('avatar1.jpg'),
        ),
      ),
      title: Text(
        student.nickName!,
        style: kTextTheme.bodyMedium,
      ),
      subtitle: Text(
        '${scoreEntity.recapScore}',
        style: kTextTheme.bodySmall,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              '$position',
              style: kTextTheme.headlineSmall,
            ),
          ),
          const Icon(
            Icons.arrow_drop_up,
            color: Palette.tosca20,
          )
        ],
      ),
    );
  }
}

class Leaderboard extends StatelessWidget {
  final List<DetailProfileEntity> profileEntity;
  final List<ScoreEntity> scores;
  const Leaderboard(
      {super.key, required this.scores, required this.profileEntity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  if (scores.length < 2) {
                    return const SizedBox.shrink();
                  }
                  ProfileEntity? current;
                  for (int i = 0; i < profileEntity.length; i++) {
                    if (scores[1].studentId == profileEntity[i].uid) {
                      current = ProfileEntity.fromDetail(profileEntity[i]);
                    }
                  }
                  if (current == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      const Avatar(
                        imageAsset: 'avatar3.jpg',
                        svgAsset: 'polygon_silver.svg',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        current.nickName ?? '',
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.purple30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        child: Text(
                          scores[1].recapScore.toString(),
                          style: kTextTheme.bodyMedium?.copyWith(
                            color: Palette.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 8),
                ClipPath(
                  clipper: CustomClipPathSilver(),
                  child: Container(
                    width: 100,
                    height: 25,
                    decoration: const BoxDecoration(color: Palette.purple40),
                  ),
                ),
                Container(
                  width: 100,
                  height: 125,
                  decoration: const BoxDecoration(
                    color: Palette.purple50,
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: kTextTheme.displayLarge
                          ?.copyWith(color: Palette.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  if (scores.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  ProfileEntity? current;
                  for (int i = 0; i < profileEntity.length; i++) {
                    if (scores[0].studentId == profileEntity[i].uid) {
                      current = ProfileEntity.fromDetail(profileEntity[i]);
                    }
                  }
                  if (current == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      const Avatar(
                        imageAsset: 'avatar1.jpg',
                        svgAsset: 'polygon_gold.svg',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        current.nickName ?? '',
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.purple30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        child: Text(
                          scores[0].recapScore.toString(),
                          style: kTextTheme.bodyMedium?.copyWith(
                            color: Palette.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 8),
                ClipPath(
                  clipper: CustomClipPathGold(),
                  child: Container(
                    width: 100,
                    height: 25,
                    decoration: const BoxDecoration(color: Palette.purple40),
                  ),
                ),
                Container(
                  width: 100,
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF9289E5),
                        Color(0xFFC2BEF1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '1',
                      style: kTextTheme.displayLarge
                          ?.copyWith(color: Palette.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Builder(builder: (context) {
                  if (scores.length < 3) {
                    return const SizedBox.shrink();
                  }
                  ProfileEntity? current;
                  for (int i = 0; i < profileEntity.length; i++) {
                    if (scores[2].studentId == profileEntity[i].uid) {
                      current = ProfileEntity.fromDetail(profileEntity[i]);
                    }
                  }
                  if (current == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      const Avatar(
                        imageAsset: 'avatar3.jpg',
                        svgAsset: 'polygon_bronze.svg',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        current.nickName ?? '',
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.purple30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        child: Text(
                          scores[2].recapScore.toString(),
                          style: kTextTheme.bodyMedium?.copyWith(
                            color: Palette.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 8),
                ClipPath(
                  clipper: CustomClipPathBronze(),
                  child: Container(
                    width: 100,
                    height: 25,
                    decoration: const BoxDecoration(color: Palette.purple40),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Palette.purple50,
                  ),
                  child: Center(
                    child: Text(
                      '3',
                      style: kTextTheme.displayLarge
                          ?.copyWith(color: Palette.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPathBronze extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 10, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPathSilver extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width - 90, 0);
    // path.lineTo(80, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPathGold extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width - 10, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width - 90, 0);
    // path.lineTo(80, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Avatar extends StatelessWidget {
  final String imageAsset;
  final String svgAsset;

  const Avatar({
    super.key,
    required this.imageAsset,
    required this.svgAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.white,
          ),
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 28,
            foregroundImage: AssetImage(
              AssetPath.getImage(imageAsset),
            ),
          ),
        ),
        Positioned(
          left: 45,
          top: 3,
          child: SvgPicture.asset(
            AssetPath.getVector(svgAsset),
            width: 25,
          ),
        ),
      ],
    );
  }
}

class LeaderboardCard extends StatelessWidget {
  final List<ProfileEntity> students;

  const LeaderboardCard({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Palette.orange20, borderRadius: BorderRadius.circular(16.0)),
      padding: const EdgeInsets.all(18),
      child: Stack(
        children: [
          Positioned(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                students.length,
                (index) => Transform.translate(
                  offset: Offset((-14 * index).toDouble(), 0),
                  child: Builder(builder: (context) {
                    if (index == 3) {
                      return Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.grey,
                        ),
                        child: Center(
                          child: Text(
                            '${students.length - 3}',
                            style: kTextTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.black,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                      width: 35,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Palette.grey),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            AssetPath.getImage('avatar${index + 1}.jpg'),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 5,
            child: Text(
              'Cek Data Nilai Praktikan',
              style: kTextTheme.bodyLarge?.copyWith(
                color: Palette.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
