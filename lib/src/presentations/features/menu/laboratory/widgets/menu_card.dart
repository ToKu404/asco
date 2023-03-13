import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final Color strokeColor;
  final Color fillColor;
  final String iconName;
  final VoidCallback? onTap;

  const MenuCard({
    super.key,
    required this.title,
    required this.strokeColor,
    required this.fillColor,
    required this.iconName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Palette.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 16,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 2,
                    color: strokeColor,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AssetPath.getIcon(iconName),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kTextTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: strokeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
