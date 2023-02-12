import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AssistantValueStudent extends StatelessWidget {
  const AssistantValueStudent({super.key});

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
              return ClipRRect(
                child: Banner(
                  color: Palette.yellow,
                  message: 'No ${index + 1}',
                  location: BannerLocation.topEnd,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                        ],
                      ),
                      trailing: Text(
                        '${97 - index}',
                        style: kTextTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: 3,
          ),
        ),
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
