import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:flutter/material.dart';

class AssistantLaboratorySchedulePage extends StatelessWidget {
  const AssistantLaboratorySchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Jadwal Asisten',
        onPressedBackButton: () => Navigator.pop(context),
      ),
    );
  }
}
