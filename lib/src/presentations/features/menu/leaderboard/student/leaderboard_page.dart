import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/student/value_recap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentLeaderboardPage extends StatelessWidget {
  const StudentLeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.purple80,
      body: SingleChildScrollView(
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
                  builder: (context) => const ValueRecap(),
                  settings: const RouteSettings(
                    name: AppRoute.valueRecapLeaderboardPage,
                  ),
                ),
              ),
              child: const LeaderboardCard(
                leaderboard: '#4',
                text: 'Kamu memperoleh nilai sementara 80.2',
                detail: 'Klik untuk melihat detail',
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ValueRecap(),
                    settings: const RouteSettings(
                      name: AppRoute.valueRecapLeaderboardPage,
                    ),
                  ),
                ),
                splashColor: Colors.transparent,
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
            ),
            const SizedBox(height: 10),
            const Leaderboard(),
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
                  return Container(
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    child: CardTile(
                      name: 'Erwin',
                      value: 88.0,
                      position: index + 4,
                      assetName: 'avatar1.jpg',
                    ),
                  );
                },
                itemCount: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final String name;
  final double value;
  final int position;
  final String assetName;

  const CardTile({
    super.key,
    required this.name,
    required this.value,
    required this.position,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: AssetImage(
          AssetPath.getImage(assetName),
        ),
      ),
      title: Text(
        'Erwin',
        style: kTextTheme.bodyMedium,
      ),
      subtitle: Text(
        '$value',
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
  const Leaderboard({super.key});

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
                const Avatar(
                  imageAsset: 'avatar1.jpg',
                  svgAsset: 'polygon_silver.svg',
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Text(
                    'Arif',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    color: Palette.purple30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    '93.7',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                const Avatar(
                  imageAsset: 'avatar1.jpg',
                  svgAsset: 'polygon_gold.svg',
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Text(
                    'Arif',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    color: Palette.purple30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    '93.7',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
                const Avatar(
                  imageAsset: 'avatar1.jpg',
                  svgAsset: 'polygon_bronze.svg',
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Text(
                    'Arif',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    color: Palette.purple30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    '93.7',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
  final String leaderboard;
  final String text;
  final String detail;

  const LeaderboardCard({
    super.key,
    required this.leaderboard,
    required this.text,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.orange20, borderRadius: BorderRadius.circular(16.0)),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Palette.orange60,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              leaderboard,
              style: kTextTheme.headlineSmall
                  ?.copyWith(color: Palette.white, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    text,
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    detail,
                    style: kTextTheme.bodyMedium,
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
