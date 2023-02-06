import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExtrasPage extends StatelessWidget {
  const ExtrasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                'Extras',
                style: kTextTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 34),
            Flexible(
              child: Row(
                children: const <Widget>[
                  CardExtras(
                    iconAsset: 'game_controller.svg',
                    title: 'Quiz',
                    text: 'Isian singkat di akhir kelas',
                    color: Palette.purple60,
                  ),
                  SizedBox(width: 12),
                  CardExtras(
                    iconAsset: 'form.svg',
                    title: 'Kuisioner',
                    text: 'Mengisi beberapa form pertanyaan',
                    color: Palette.red,
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

class CardExtras extends StatelessWidget {
  const CardExtras({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.text,
    required this.color,
  });

  final String iconAsset;
  final String title;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width / 2 - 25,
      child: Stack(
        children: [
          Positioned(
            left: 48,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
              ),
              child: SvgPicture.asset(
                AssetPath.getVector('attr.svg'),
                width: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(
                    AssetPath.getIcons(iconAsset),
                  ),
                ),
                const SizedBox(height: 24),
                Flexible(
                  child: Text(
                    title,
                    style: kTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    text,
                    style: kTextTheme.bodySmall,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
