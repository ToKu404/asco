import 'package:flutter/material.dart';
import 'package:asco/core/constants/app_route.dart';

class AssistantAssistanceCourseDetailPage extends StatelessWidget {
  const AssistantAssistanceCourseDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void showAssistantAssistanceCourseDetailPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AssistantAssistanceCourseDetailPage(),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistanceCourseDetailPage,
      ),
    ),
  );
}
