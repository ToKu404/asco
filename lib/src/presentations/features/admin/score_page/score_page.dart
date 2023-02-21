import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_practicum_page.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/assistant/assistant_value_recap.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_banners/super_banners.dart';

void showAdminScorePage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminScorePage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminScorePage extends StatefulWidget {
  const AdminScorePage({super.key});

  @override
  State<AdminScorePage> createState() => _AdminScorePageState();
}

class _AdminScorePageState extends State<AdminScorePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Palette.white,
          ),
        ),
        title: Text(
          'Nilai Praktikan',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.blackPurple,
          shape: const CircleBorder(
              side: BorderSide(width: 1, color: Palette.purple60)),
          child: const Icon(
            Icons.add_rounded,
            color: Palette.white,
          ),
          onPressed: () {
            showAdminCreatePracticumPage(context: context);
          }),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: AppSize.getAppWidth(context),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.purple60,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.upload_file_rounded,
                  size: 20,
                  color: Palette.white,
                ),
                label: Text(
                  'Export ke Excel',
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                onChanged: (value) {},
                keyboardType: TextInputType.text,
                style: kTextTheme.bodyLarge?.copyWith(
                  color: Palette.blackPurple,
                ),
                cursorColor: Palette.blackPurple,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: 'Cari nama praktikum',
                  hintStyle:
                      kTextTheme.bodyLarge?.copyWith(color: Palette.disable),
                  filled: true,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: SvgPicture.asset(
                          AssetPath.getIcons('search_outlined.svg'),
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                  prefixIconColor: Palette.blackPurple,
                  fillColor: Palette.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.blackPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.blackPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  StudentScoreCard(),
                  SizedBox(
                    height: 8,
                  ),
                  StudentScoreCard(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class StudentScoreCard extends StatelessWidget {
  const StudentScoreCard({
    super.key,
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
              leading: const Avatar(imageAsset: 'avatar1.jpg'),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'H071191049',
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Erwin',
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.purple60,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          'Kelas B',
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Palette.purple60,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          'Group #4',
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                '${97}',
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

class Avatar extends StatelessWidget {
  final String imageAsset;

  const Avatar({
    super.key,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Palette.white,
      ),
      padding: const EdgeInsets.all(2.0),
      child: CircleAvatar(
        radius: 28,
        foregroundImage: AssetImage(
          AssetPath.getImage(imageAsset),
        ),
      ),
    );
  }
}
