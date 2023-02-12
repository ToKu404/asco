import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';

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
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

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
        controller: _controller,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: "Cari nama atau nim",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Palette.purple20,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Palette.purple80,
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
                    _controller.clear();

                    widget.onChanged('');
                  },
                ),
        ),
        style: const TextStyle(
          color: Palette.purple80,
        ),
      ),
    );
  }
}
