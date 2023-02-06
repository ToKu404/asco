import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';

class StudentAssistanceCourseDetailPage extends StatelessWidget {
  const StudentAssistanceCourseDetailPage({super.key});

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
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                      child: Text(
                        'Flutter Forward: Introducing to Flutter 3.7',
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Palette.violet60.withOpacity(.8),
                      Palette.violet60.withOpacity(.4),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.auto_stories_outlined,
                    size: 20,
                  ),
                  label: const Text('Buka Soal Praktikum'),
                  style: TextButton.styleFrom(
                    backgroundColor: Palette.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const TitleSection(title: 'Status Tugas Praktikum'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Palette.white,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.purple60,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.check_rounded,
                      size: 18,
                      color: Palette.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Terkumpul',
                      style: TextStyle(
                        color: Palette.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const TitleSection(title: 'Batas Waktu Asistensi'),
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                animation: true,
                animationDuration: 1000,
                curve: Curves.easeOut,
                percent: 0.7,
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
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 4),
                child: Text(
                  '3 Hari, 2 Jam',
                  textAlign: TextAlign.end,
                  style: kTextTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Palette.purple80,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const TitleSection(title: 'Absensi'),
              Column(
                children: <Widget>[
                  Container(
                    width: AppSize.getAppWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Palette.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Asistensi 1',
                                  style: kTextTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Palette.purple100,
                                  ),
                                ),
                                Text(
                                  '20 Februari 2022',
                                  style: kTextTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF97979A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Palette.purple60.withOpacity(.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  'Tepat Waktu',
                                  style: kTextTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Palette.purple60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: AppSize.getAppWidth(context) - 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      color: Palette.purple80,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String title;

  const TitleSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: kTextTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: Palette.purple100,
        ),
      ),
    );
  }
}
