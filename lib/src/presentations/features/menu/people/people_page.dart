import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
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
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Eurico Devon',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Koordinator Lab',
                        badgeId: 0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Richard Enrico',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Asisten',
                        badgeId: 1,
                      ),
                      TempBadgeHelper(
                        title: 'Pemateri',
                        badgeId: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Ardn',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Asisten',
                        badgeId: 1,
                      ),
                      TempBadgeHelper(
                        title: 'Pemateri',
                        badgeId: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Eurico Devon',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Pemateri',
                        badgeId: 2,
                      ),
                    ],
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
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Eurico Devon',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Group #1',
                        badgeId: 3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Richard Enrico',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Group #1',
                        badgeId: 3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Ardn',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Group #1',
                        badgeId: 3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _BuildPeopleCard(
                    path: AssetPath.getImage('avatar1.jpg'),
                    name: 'Eurico Devon',
                    listBadgeModel: [
                      TempBadgeHelper(
                        title: 'Group #2',
                        badgeId: 3,
                      ),
                    ],
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
    return Row(
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
    );
  }
}
