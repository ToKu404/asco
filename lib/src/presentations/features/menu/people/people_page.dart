import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';

class PeoplePage extends StatefulWidget {
  final String practicumUid;

  const PeoplePage({super.key, required this.practicumUid});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false)
          .fetchAll(practicumUid: widget.practicumUid),
    );
  }

  @override
  Widget build(BuildContext context) {
    final peopleNotifier = context.watch<ProfileNotifier>();

    if (peopleNotifier.isLoadingState('find') ||
        peopleNotifier.listData.isEmpty) {
      return const AscoLoading();
    }

    if (peopleNotifier.isErrorState('find')) {
      return const Center(
        child: Text('unknown error occured'),
      );
    }

    final listAssistant = peopleNotifier.listData
        .where((people) => people.userRole!.id == 2)
        .toList();
    final listStudent = peopleNotifier.listData
        .where((people) => people.userRole!.id == 1)
        .toList();

    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            if (listAssistant.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Asisten',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.purple80,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return _BuildPeopleCard(
                          imgUrl: '${listAssistant[index].profilePhoto}',
                          name: '${listAssistant[index].fullName}',
                          listBadgeModel: <TempBadgeHelper>[
                            TempBadgeHelper(
                              title: 'Asisten',
                              badgeId: 1,
                            ),
                          ],
                        );
                      },
                      itemCount: listAssistant.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Praktikan',
                    style: kTextTheme.titleMedium?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return _BuildPeopleCard(
                        imgUrl: '${listStudent[index].profilePhoto}',
                        name: '${listStudent[index].fullName}',
                        listBadgeModel: <TempBadgeHelper>[
                          TempBadgeHelper(
                            title:
                                'Group #${listStudent[index].userPracticums?[widget.practicumUid]?.group?.name}',
                            badgeId: 3,
                          ),
                          TempBadgeHelper(
                            title:
                                'Kelas ${listStudent[index].userPracticums?[widget.practicumUid]?.classroom?.classCode}',
                            badgeId: 4,
                          ),
                        ],
                      );
                    },
                    itemCount: listStudent.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildPeopleCard extends StatelessWidget {
  final String imgUrl;
  final String name;
  final List<TempBadgeHelper> listBadgeModel;

  const _BuildPeopleCard({
    required this.imgUrl,
    required this.name,
    required this.listBadgeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleNetworkImage(
              width: 44,
              height: 44,
              imgUrl: imgUrl,
              placeholderSize: 16,
              errorIcon: Icons.person_rounded,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: kTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.purple100,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: listBadgeModel
                        .map((badge) => BuildBadge(badgeHelper: badge))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
