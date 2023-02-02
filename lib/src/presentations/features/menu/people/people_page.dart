import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';

class StudentPeoplePage extends StatelessWidget {
  const StudentPeoplePage({super.key});

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

class TempBadgeHelper {
  final int badgeId;
  final String title;

  TempBadgeHelper({required this.badgeId, required this.title});
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
    final _badge = [
      Palette.purple100,
      Palette.purple80,
      Palette.plum80,
      Palette.purple60
    ];

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
                      (badgeModel) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: _badge[badgeModel.badgeId],
                        ),
                        child: Text(
                          badgeModel.title,
                          style: kTextTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.white,
                          ),
                        ),
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
