import 'package:asco/core/constants/color_const.dart';
import 'package:flutter/material.dart';

class StudentLaboratoriumCourseDetailPage extends StatelessWidget {
  const StudentLaboratoriumCourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        title: const Text('Pertemuan 1'),
        centerTitle: true,
      ),
    );
  }
}
