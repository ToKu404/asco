import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/data/datasources/helpers/update_data_helper.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/providers/score_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/search_field.dart';

class AssistantLaboratoryQuizValueInputPage extends StatefulWidget {
  final String meetingUid;
  final List<ProfileEntity> listStudents;

  const AssistantLaboratoryQuizValueInputPage({
    super.key,
    required this.meetingUid,
    required this.listStudents,
  });

  @override
  State<AssistantLaboratoryQuizValueInputPage> createState() =>
      _AssistantLaboratoryQuizValueInputPageState();
}

class _AssistantLaboratoryQuizValueInputPageState
    extends State<AssistantLaboratoryQuizValueInputPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => context.read<MeetingNotifier>().getDetail(uid: widget.meetingUid),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meetingNotifier = context.watch<MeetingNotifier>();

    if (meetingNotifier.isLoadingState('single') ||
        meetingNotifier.data == null) {
      return const AscoLoading(
        withScaffold: true,
      );
    }

    if (meetingNotifier.isErrorState('single')) {
      return Center(
        child: Text(meetingNotifier.message),
      );
    }

    final meetingData = meetingNotifier.data;

    return Scaffold(
      backgroundColor: Palette.grey,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              centerTitle: true,
              title: const Text('Input Nilai Quiz'),
              titleTextStyle: kTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Palette.white,
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Palette.white,
                  size: 30,
                ),
                tooltip: 'Back',
              ),
              forceElevated: innerBoxIsScrolled,
              bottom: BottomAppBar(
                maxScore: meetingData?.maxQuizScore,
              ),
              shadowColor: Palette.grey,
              backgroundColor: Palette.purple80,
            ),
          ];
        },
        body: MasonryGridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 24,
          crossAxisSpacing: 16,
          itemCount: widget.listStudents.length,
          itemBuilder: (_, i) => QuizValueCard(
            score: meetingData!.attendances
                ?.firstWhere((s) => s.studentUid == widget.listStudents[i].uid)
                .quizScore,
            maxScore: meetingData.maxQuizScore!,
            meetingId: widget.meetingUid,
            student: widget.listStudents[i],
            listAttendance: meetingData.attendances!,
          ),
        ),
      ),
    );
  }
}

class BottomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int? maxScore;

  const BottomAppBar({
    super.key,
    required this.maxScore,
  });

  @override
  State<BottomAppBar> createState() => _BottomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _BottomAppBarState extends State<BottomAppBar> {
  // default is 56.0
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.preferredSize.height,
      color: Palette.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: <Color>[
                  Palette.purple60,
                  Palette.purple80,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Total Poin',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    widget.maxScore == null ? "-" : widget.maxScore.toString(),
                    style: kTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SearchField(
            text: '',
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

class QuizValueCard extends StatelessWidget {
  final String meetingId;
  final ProfileEntity student;
  final List<AttendanceEntity> listAttendance;
  final int? score;
  final int maxScore;

  const QuizValueCard({
    super.key,
    required this.meetingId,
    required this.student,
    required this.listAttendance,
    required this.score,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      radius: 12,
      color: Palette.white,
      padding: const EdgeInsets.all(12),
      border: Border.all(color: Palette.purple80),
      boxShadow: <BoxShadow>[
        BoxShadow(
          spreadRadius: 2,
          color: Palette.purple80,
          offset: Offset.fromDirection(20, 3.5),
        ),
      ],
      onTap: () => showBottomSheet(
        context: context,
        builder: (context) => CustomBottomSheet(
          student: student,
          listAttendance: listAttendance,
          meetingUid: meetingId,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      children: <Text>[
                        Text(
                          score != null ? score.toString() : "-",
                          style: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple80,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Poin',
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.purple60,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      direction: Axis.vertical,
                      children: <Text>[
                        Text(
                          maxScore.toString(),
                          style: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Palette.purple80,
                            height: 1,
                          ),
                        ),
                        Text(
                          'Maks.',
                          style: kTextTheme.bodySmall?.copyWith(
                            color: Palette.purple60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CircularPercentIndicator(
                animation: true,
                animationDuration: 1000,
                curve: Curves.easeOut,
                reverse: true,
                radius: 35,
                lineWidth: 8,
                percent: score == null ? 0 : score! / maxScore,
                progressColor: Palette.purple60,
                backgroundColor: Colors.transparent,
                circularStrokeCap: CircularStrokeCap.round,
                center: Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.purple80,
                  ),
                  child: Center(
                    child: Text(
                      (score ?? 0 / maxScore * 100).toStringAsFixed(1),
                      style: kTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleNetworkImage(
                width: 36,
                height: 36,
                imgUrl: student.profilePhoto ?? '',
                placeholderSize: 12,
                errorIcon: Icons.person_rounded,
                withBorder: true,
                borderWidth: 1.5,
                borderColor: Palette.purple80,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Text>[
                    Text(
                      student.username ?? '',
                      style: kTextTheme.bodySmall?.copyWith(
                        color: Palette.purple60,
                      ),
                    ),
                    Text(
                      student.nickName ?? '',
                      style: kTextTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Palette.purple80,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomBottomSheet extends StatefulWidget {
  final String meetingUid;
  final ProfileEntity student;
  final List<AttendanceEntity> listAttendance;

  const CustomBottomSheet({
    super.key,
    required this.meetingUid,
    required this.student,
    required this.listAttendance,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<ScoreNotifier>()
      ..fetchMultiple(listStudentId: [widget.student.uid!]));
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ScoreNotifier>();

    if (notifier.isSuccessState('multiple')) {
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 30),
        decoration: const BoxDecoration(
          color: Palette.purple100,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Palette.grey50,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.student.nickName ?? '',
              style: kTextTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Palette.white,
              ),
            ),
            Text(
              widget.student.username ?? '',
              style: kTextTheme.bodyLarge?.copyWith(
                color: Palette.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      style: kTextTheme.bodyLarge?.copyWith(
                        color: Palette.purple80,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: InputBorder.none,
                        hintText: 'Tambahan poin',
                        hintStyle: kTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Palette.purple20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 44,
                  height: 44,
                  child: IconButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        final result = UpdateDataHelper.updateAttendance(
                          studentUid: widget.student.uid ?? '',
                          attendanceList: widget.listAttendance,
                          updateAttendance: AttendanceEntity(
                            quizScore: int.parse(textEditingController.text),
                          ),
                        );

                        if (notifier.listData.isNotEmpty) {
                          double sum = 0;
                          int count = 0;

                          for (int i = 0; i < result.length; i++) {
                            // if (result[i].quizScore != null) {
                            sum += result[i].quizScore ?? 0;
                            count++;
                          }

                          double avgScore = count > 0 ? sum / count : 0;

                          final score = UpdateDataHelper.updateScore(
                            updateScoreType: UpdateScoreType.quiz,
                            scoreEntity: notifier.listData.first,
                            newScore: avgScore,
                          );

                          context
                              .read<ScoreNotifier>()
                              .update(uid: widget.student.uid!, score: score);
                        }

                        context
                            .read<MeetingNotifier>()
                            .updateAttendance(
                              uid: widget.meetingUid,
                              listAttendanceModel: result,
                            )
                            .then((value) => Navigator.pop(context));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_upward,
                      color: Color.fromRGBO(116, 75, 228, 1),
                      size: 20,
                    ),
                    tooltip: 'Submit',
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

void showAssistantLaboratoryQuizValueInputPage(
  BuildContext context, {
  required String meetingUid,
  required List<ProfileEntity> listStudents,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantLaboratoryQuizValueInputPage(
        meetingUid: meetingUid,
        listStudents: listStudents,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantLaboratoryQuizValueInputPage,
      ),
    ),
  ).then((value) => context.read<MeetingNotifier>().getDetail(uid: meetingUid));
}
