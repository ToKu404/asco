import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeoplePage extends StatefulWidget {
  final String practicumUid;
  const PeoplePage({
    super.key,
    required this.practicumUid,
  });

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<ProfileNotifier>(context, listen: false)
            ..fetchAll(practicumUid: widget.practicumUid),
        });
  }

  @override
  Widget build(BuildContext context) {
    final peopleNotifier = context.watch<ProfileNotifier>();

    if (peopleNotifier.isLoadingState('find') ||
        peopleNotifier.listData.isEmpty) {
      return const AscoLoading(
        withScaffold: true,
      );
    }
    final listPeople = peopleNotifier.listData;
    final listAssistant = listPeople.where((e) => e.userRole!.id == 2).toList();
    final listStudent =
        listPeople.where((element) => element.userRole!.id == 1).toList();
    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            if (listAssistant.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.white,
                ),
                padding: const EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Asisten',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.purple80,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return _BuildPeopleCard(
                          path: AssetPath.getImage('avatar1.jpg'),
                          name: "${listAssistant[index].fullName}",
                          listBadgeModel: [
                            TempBadgeHelper(
                              title: 'Asisten',
                              badgeId: 2,
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
            const SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.white,
              ),
              padding: const EdgeInsets.all(
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Praktikan',
                    style: kTextTheme.titleMedium?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return _BuildPeopleCard(
                        path: AssetPath.getImage('avatar1.jpg'),
                        name: "${listStudent[index].fullName}",
                        listBadgeModel: [
                          TempBadgeHelper(
                              badgeId: 3,
                              title:
                                  "Group #${listStudent[index].userPracticums?[widget.practicumUid]?.group?.name}"),
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
  final String path;
  final String name;
  final List<TempBadgeHelper> listBadgeModel;
  const _BuildPeopleCard({
    required this.path,
    required this.listBadgeModel,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Palette.purple60,
                ),
                shape: BoxShape.circle,
                color: Palette.disable,
                image: DecorationImage(
                  image: AssetImage(path),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Palette.black,
                  ),
                ),
                Row(
                  children: [
                    ...listBadgeModel
                        .map(
                          (badgeModel) => BuildBadge(
                            badgeHelper: badgeModel,
                          ),
                        )
                        .toList()
                  ],
                )
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
