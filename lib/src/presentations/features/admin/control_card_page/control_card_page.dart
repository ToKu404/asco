import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/assistant/assistant_value_recap.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showAdminControlCardPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminControlCardPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminControlCardPage extends StatefulWidget {
  const AdminControlCardPage({super.key});

  @override
  State<AdminControlCardPage> createState() => _AdminControlCardPageState();
}

class _AdminControlCardPageState extends State<AdminControlCardPage> {
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
          'Pemrograman Mobile',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
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
                  hintText: 'Cari nim atau nama lengkap',
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
                  StudentCard(),
                  SizedBox(
                    height: 8,
                  ),
                  StudentCard(),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          InkWellContainer(
            color: Palette.white,
            onTap: () {},
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
            ),
          ),
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

class PracticumCard extends StatelessWidget {
  const PracticumCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      onTap: () {},
      radius: 12,
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                AssetPath.getVector('badge_android.svg'),
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
                    'Pemrograman Mobile',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '5 Kelas',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
