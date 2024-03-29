import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/mentor_tile.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:asco/src/presentations/widgets/title_section.dart';

class StudentLaboratoryCourseDetailPage extends StatefulWidget {
  final int meetingNumber;
  final DetailMeetingEntity meetingDetail;

  const StudentLaboratoryCourseDetailPage({
    super.key,
    required this.meetingNumber,
    required this.meetingDetail,
  });

  @override
  State<StudentLaboratoryCourseDetailPage> createState() =>
      _StudentLaboratoryCourseDetailPageState();
}

class _StudentLaboratoryCourseDetailPageState
    extends State<StudentLaboratoryCourseDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false).fetchMultiple(
        multipleId: <String>[
          widget.meetingDetail.assistant1Uid!,
          widget.meetingDetail.assistant2Uid!,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, profileNotifier, child) {
        if (profileNotifier.isSuccessState('multiple')) {
          return buildMainPage(
            context,
            assistant1: profileNotifier.listData
                .where((e) => e.uid == widget.meetingDetail.assistant1Uid!)
                .first,
            assistant2: profileNotifier.listData
                .where((e) => e.uid == widget.meetingDetail.assistant2Uid!)
                .first,
          );
        }

        if (profileNotifier.isErrorState('multiple')) {
          return const Scaffold(
            backgroundColor: Palette.grey,
            body: Center(
              child: Text('unknown error occured'),
            ),
          );
        }

        return const AscoLoading(
          withScaffold: true,
        );
      },
    );
  }

  Scaffold buildMainPage(
    BuildContext context, {
    required DetailProfileEntity assistant1,
    required DetailProfileEntity assistant2,
  }) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: PurpleAppBar(
        titleText: 'Pertemuan ${widget.meetingNumber}',
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
                  alignment: AlignmentDirectional.bottomEnd,
                  children: <Widget>[
                    RotatedBox(
                      quarterTurns: -2,
                      child: SvgPicture.asset(
                        AssetPath.getVector('bg_attribute.svg'),
                        width: AppSize.getAppWidth(context) / 2,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                          child: Text(
                            widget.meetingDetail.topic!,
                            style: kTextTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Palette.white,
                            ),
                          ),
                        ),
                        MentorTile(
                          name: assistant1.fullName!,
                          role: 'Pemateri',
                          image: assistant1.profilePhoto!,
                        ),
                        MentorTile(
                          name: assistant2.fullName!,
                          role: 'Pendamping',
                          image: assistant2.profilePhoto!,
                        ),
                        const SizedBox(height: 12),
                      ],
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
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 16,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.auto_stories_outlined,
                    size: 20,
                  ),
                  label: const Text('Buka Modul'),
                  style: TextButton.styleFrom(
                    backgroundColor: Palette.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ContainerSection(
                children: <Widget>[
                  const TitleSection(title: 'Status Pertemuan'),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D673F).withOpacity(.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Selesai',
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF1D673F),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const TitleSection(title: 'Quiz'),
                  CourseDetailTile(
                    title: 'Quiz Pertemuan 1',
                    subtitle: '10 Menit',
                    hasTwoSubtitles: true,
                    secondSubtitle: '5 Soal',
                    titleColor: Palette.purple100,
                    subtitleColor: Palette.purple60,
                    backgroundColor: Palette.purple10,
                    leadingBackgroundColor: Palette.purple20,
                    leading: SvgPicture.asset(
                      AssetPath.getVector('logo2.svg'),
                      width: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const TitleSection(title: 'Absensi'),
                  const CourseDetailTile(
                    title: 'Hadir',
                    subtitle: 'Terlambat 15 Menit',
                    titleColor: Palette.purple100,
                    subtitleColor: Palette.salmon40,
                    backgroundColor: Palette.white,
                    leadingBackgroundColor: Color(0xFF86DEAF),
                    leading: Icon(
                      Icons.check_rounded,
                      size: 20,
                      color: Palette.white,
                    ),
                    tileShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 0),
                        spreadRadius: 2,
                        color: Palette.purple80,
                      ),
                      BoxShadow(
                        offset: Offset(3, 3),
                        spreadRadius: 2,
                        color: Palette.purple80,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ContainerSection(
                children: <Widget>[
                  const TitleSection(title: 'Nilai Quiz'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 3000,
                        curve: Curves.easeOut,
                        radius: 50,
                        lineWidth: 10,
                        percent: .78,
                        progressColor: Palette.purple60,
                        backgroundColor: Colors.transparent,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(9),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.purple80,
                          ),
                          child: Center(
                            child: Text(
                              '78.0',
                              style: kTextTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Palette.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: const <Widget>[
                                Expanded(
                                  child: QuizAssessmentBox(
                                    title: 'Benar',
                                    value: 4,
                                    backgroundColor: Palette.azure20,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: QuizAssessmentBox(
                                    title: 'Salah',
                                    value: 1,
                                    backgroundColor: Palette.plum20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2CF74),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const Flexible(
                                    child: Badge(
                                      label: Text(
                                        '+10',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      textColor: Color(0xFFF2CF74),
                                      backgroundColor: Palette.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'Poin Bonus',
                                      style: kTextTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Palette.white,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerSection extends StatelessWidget {
  final List<Widget> children;

  const ContainerSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class CourseDetailTile extends StatelessWidget {
  final Color? backgroundColor;
  final Color? leadingBackgroundColor;
  final Widget? leading;
  final List<BoxShadow>? tileShadow;
  final String title;
  final Color? titleColor;
  final String subtitle;
  final Color? subtitleColor;
  final bool hasTwoSubtitles;
  final String secondSubtitle;

  const CourseDetailTile({
    super.key,
    this.backgroundColor,
    this.leadingBackgroundColor,
    this.leading,
    this.tileShadow,
    required this.title,
    this.titleColor,
    required this.subtitle,
    this.subtitleColor,
    this.hasTwoSubtitles = false,
    this.secondSubtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: tileShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: leadingBackgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: leading,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: kTextTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: subtitleColor,
                        ),
                      ),
                    ),
                    if (hasTwoSubtitles) ...[
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                          color: subtitleColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          secondSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kTextTheme.bodyMedium?.copyWith(
                            color: subtitleColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizAssessmentBox extends StatelessWidget {
  final int value;
  final String title;
  final Color backgroundColor;

  const QuizAssessmentBox({
    super.key,
    required this.value,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Text>[
          Text(
            '$value',
            style: kTextTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: Palette.grey,
              height: 1,
            ),
          ),
          Text(
            title,
            style: kTextTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Palette.grey,
            ),
          ),
        ],
      ),
    );
  }
}

void showStudentLaboratoryCourseDetailPage(
  BuildContext context, {
  required int meetingNumber,
  required DetailMeetingEntity meetingDetail,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => StudentLaboratoryCourseDetailPage(
        meetingNumber: meetingNumber,
        meetingDetail: meetingDetail,
      ),
      settings: const RouteSettings(
        name: AppRoute.studentLaboratoryCourseDetailPage,
      ),
    ),
  );
}
