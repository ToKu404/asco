import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/dummy_data.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';
import 'package:asco/src/presentations/widgets/custom_badge.dart';
import 'package:asco/src/presentations/widgets/custom_student_card.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:asco/src/presentations/widgets/title_section.dart';

class AssistantAssistanceCourseDetailPage extends StatelessWidget {
  final String title;

  const AssistantAssistanceCourseDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Pertemuan 1',
        onPressedBackButton: () => Navigator.pop(context),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                color: Palette.purple80,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: RotatedBox(
                        quarterTurns: -2,
                        child: SvgPicture.asset(
                          AssetPath.getVector('bg_attribute.svg'),
                          width: AppSize.getAppWidth(context) / 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                      child: Text(
                        title,
                        style: kTextTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Palette.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              elevation: 0,
              pinned: true,
              automaticallyImplyLeading: false,
              toolbarHeight: 6,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Palette.violet60,
                      Palette.violet30,
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const TitleSection(title: 'Soal Praktikum'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.auto_stories_outlined,
                        size: 20,
                      ),
                      label: const Text('Tampilkan'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Palette.azure20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.file_upload_outlined,
                      color: Palette.white,
                      size: 20,
                    ),
                    tooltip: 'Upload',
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.purple60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      color: Palette.white,
                      size: 20,
                    ),
                    tooltip: 'Delete',
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.plum20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TitleSection(title: 'Batas Waktu Asistensi'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          animation: true,
                          animationDuration: 1000,
                          curve: Curves.easeOut,
                          percent: 0.8,
                          lineHeight: 24,
                          barRadius: const Radius.circular(24),
                          backgroundColor: Palette.white,
                          linearGradient: const LinearGradient(
                            colors: <Color>[
                              Palette.purple60,
                              Palette.purple80,
                            ],
                          ),
                          clipLinearGradient: true,
                          widgetIndicator: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 14, right: 45),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.white,
                            ),
                            child: const Icon(
                              Icons.schedule_rounded,
                              size: 16,
                              color: Palette.purple100,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '3 Hari, 2 Jam',
                            style: kTextTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Palette.purple80,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: Palette.white,
                      size: 20,
                    ),
                    tooltip: 'Select Date Range',
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFE395E7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TitleSection(title: 'Nilai Tugas Praktikum'),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Palette.purple60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Input Nilai'),
                ),
              ),
              const SizedBox(height: 20),
              const TitleSection(
                title: 'Asistensi',
                paddingBottom: 12,
              ),
              ...students
                  .map((student) => buildStudentCard(context, student))
                  .toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 4,
        backgroundColor: Palette.purple100,
        foregroundColor: Palette.white,
        shape: const CircleBorder(
          side: BorderSide(
            width: 2,
            color: Palette.purple60,
          ),
        ),
        tooltip: 'Scan QR',
        child: const Icon(Icons.qr_code_scanner_outlined),
      ),
    );
  }

  Padding buildStudentCard(BuildContext context, Student student) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomStudentCard(
        student: student,
        onTap: () {},
        isThreeLine: true,
        thirdLine: BuildBadge(
          badgeHelper: TempBadgeHelper(
            badgeId: 3,
            title: 'Kelas A',
          ),
        ),
        hasTrailing: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            CircleBorderContainer(
              size: 30,
              borderColor: Palette.purple80,
              fillColor: Palette.purple60,
              child: Icon(
                Icons.check_rounded,
                size: 16,
                color: Palette.white,
              ),
            ),
            SizedBox(width: 4),
            CircleBorderContainer(
              size: 30,
              borderColor: Color(0xFFD35380),
              fillColor: Color(0xFFFA78A6),
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: Palette.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAssistantAssistanceCourseDetailPage(
  BuildContext context,
  String title,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantAssistanceCourseDetailPage(title: title),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistanceCourseDetailPage,
      ),
    ),
  );
}
