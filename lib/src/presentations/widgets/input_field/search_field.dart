import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';

class SearchField extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const SearchField({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        border: Border.all(color: Palette.purple80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        textAlignVertical: TextAlignVertical.center,
        style: kTextTheme.bodyLarge?.copyWith(
          color: Palette.purple80,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Cari nama atau nim",
          hintStyle: kTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: Palette.purple20,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 16,
              end: 12,
            ),
            child: SvgPicture.asset(
              AssetPath.getIcons('search_outlined.svg'),
              color: Palette.purple80,
            ),
          ),
          suffixIcon: widget.text.isEmpty
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Palette.purple80,
                    size: 16,
                  ),
                  onPressed: () {
                    controller.clear();
                    widget.onChanged('');
                  },
                ),
        ),
      ),
    );
  }
}
