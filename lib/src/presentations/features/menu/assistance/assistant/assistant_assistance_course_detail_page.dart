import 'dart:async';

import 'package:asco/src/domain/entities/assistance_entities/assistance_entities.dart';
import 'package:asco/src/presentations/providers/control_card_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistant/assistant_assistance_practicum_value_input_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/assistance_dialog.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/assistance_status_dialog.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';
import 'package:asco/src/presentations/widgets/custom_student_card.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:asco/src/presentations/widgets/title_section.dart';
import 'package:provider/provider.dart';

class AssistantAssistanceCourseDetailPage extends StatefulWidget {
  final String title;
  final List<ProfileEntity> students;
  final int meetingNumber;

  const AssistantAssistanceCourseDetailPage({
    super.key,
    required this.title,
    required this.students,
    required this.meetingNumber,
  });

  @override
  State<AssistantAssistanceCourseDetailPage> createState() =>
      _AssistantAssistanceCourseDetailPageState();
}

class _AssistantAssistanceCourseDetailPageState
    extends State<AssistantAssistanceCourseDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<ControlCardNotifier>().fetchMultiple(
          listStudentId:
              widget.students.map((e) => e.uid).toList().cast<String>());
    });
    super.initState();
  }

  DateTimeRange _dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 6)),
  );

  @override
  Widget build(BuildContext context) {
    final ccNotifier = context.watch<ControlCardNotifier>();
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
                        widget.title,
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
                            '3 hari lagi (10 Apr)',
                            style: kTextTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Palette.purple80,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => showAssistanceDateRangePicker(context),
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: Palette.white,
                      size: 20,
                    ),
                    tooltip: 'Date Range',
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
              const TitleSection(title: 'Nilai Praktikum'),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    showAssistantAssistancePracticumValueInputPage(context);
                  },
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
              Builder(builder: (context) {
                if (ccNotifier.isLoadingState('multiple')) {
                  return const AscoLoading();
                }
                if (ccNotifier.isErrorState('multiple')) {
                  return Center(
                    child: Text(ccNotifier.message),
                  );
                }
                final data = ccNotifier.listData;

                return ListView.builder(
                  itemBuilder: (context, index) {
                    ControlCardResultEntity? ccEntity;
                    for (int i = 0; i < data.length; i++) {
                      if (data[i].student?.uid == widget.students[index].uid) {
                        ccEntity = data[i];
                        break;
                      }
                    }
                    return ccEntity != null
                        ? BuildStudentCard(
                            student: widget.students[index],
                            meetingNumber: widget.meetingNumber,
                            ccEntity: ccEntity,
                          )
                        : Text(
                            'Error: No data found for student ${widget.students[index].uid}');
                  },
                  itemCount: widget.students.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              }),
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

  Future<void> showAssistanceDateRangePicker(BuildContext context) async {
    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: _dateRange,
      firstDate: DateTime(_dateRange.start.year),
      lastDate: DateTime(_dateRange.start.year, 12, 31),
      currentDate: _dateRange.start,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'Tentukan Waktu Asistensi',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Palette.purple30,
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  iconTheme: const IconThemeData(color: Palette.purple80),
                ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Palette.purple30,
                  onPrimary: Palette.purple80,
                ),
          ),
          child: child!,
        );
      },
    );

    if (newDateRange != null) {
      _dateRange = newDateRange;
    }
  }
}

void showAssistantAssistanceCourseDetailPage(
  BuildContext context, {
  required String title,
  required List<ProfileEntity> students,
  required int meetingNumber,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantAssistanceCourseDetailPage(
        meetingNumber: meetingNumber,
        title: title,
        students: students,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantAssistanceCourseDetailPage,
      ),
    ),
  );
}

class BuildStudentCard extends StatefulWidget {
  final int meetingNumber;
  final ProfileEntity student;
  final ControlCardResultEntity ccEntity;
  const BuildStudentCard({
    super.key,
    required this.meetingNumber,
    required this.student,
    required this.ccEntity,
  });

  @override
  State<BuildStudentCard> createState() => _BuildStudentCardState();
}

class _BuildStudentCardState extends State<BuildStudentCard> {
  Timer? _timer;

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ControlCardEntity? ccEntity;
    for (var i = 0; i < widget.ccEntity.data!.length; i++) {
      if (widget.meetingNumber == i + 1) {
        ccEntity = widget.ccEntity.data![i];
        break;
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomStudentCard(
        student: widget.student,
        hasTrailing: true,
        trailing: ccEntity != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleBorderContainer(
                      size: 30,
                      borderColor: ccEntity.assistance1 != null
                          ? Palette.purple80
                          : const Color(0xFFD35380),
                      fillColor: ccEntity.assistance1 == null
                          ? const Color(0xFFFA78A6)
                          : Palette.purple60,
                      onTap: () => showDialog(
                            context: context,
                            barrierLabel: '',
                            barrierDismissible: false,
                            builder: (_) => AssistanceDialog(
                              number: widget.meetingNumber,
                              student: widget.student,
                              isFirstAssistance: true,
                              controlCardResultEntity: widget.ccEntity,
                            ),
                          ).then((value) {
                            final isSubmitted =
                                value == null ? false : value as bool;

                            if (isSubmitted) {
                              showStatusDialog(context,
                                  number: 1, student: widget.student);
                            }
                          }),
                      child: Icon(
                        ccEntity.assistance1 != null
                            ? Icons.check
                            : Icons.close_rounded,
                        size: 16,
                        color: Palette.white,
                      )),
                  const SizedBox(width: 4),
                  CircleBorderContainer(
                      size: 30,
                      borderColor: ccEntity.assistance2 != null
                          ? Palette.purple80
                          : const Color(0xFFD35380),
                      fillColor: ccEntity.assistance2 == null
                          ? const Color(0xFFFA78A6)
                          : Palette.purple60,
                      onTap: () => showDialog(
                            context: context,
                            barrierLabel: '',
                            barrierDismissible: false,
                            builder: (_) => AssistanceDialog(
                              number: 2,
                              student: widget.student,
                              isFirstAssistance: false,
                              controlCardResultEntity: widget.ccEntity,
                            ),
                          ).then((value) {
                            final isSubmitted =
                                value == null ? false : value as bool;

                            if (isSubmitted) {
                              showStatusDialog(context,
                                  number: 2, student: widget.student);
                            }
                          }),
                      child: Icon(
                        ccEntity.assistance2 != null
                            ? Icons.check
                            : Icons.close_rounded,
                        size: 16,
                        color: Palette.white,
                      )),
                ],
              )
            : null,
      ),
    );
  }

  void showStatusDialog(
    BuildContext context, {
    required int number,
    required ProfileEntity student,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        _timer = Timer(
          const Duration(milliseconds: 4000),
          () => Navigator.popUntil(
            context,
            ModalRoute.withName(
              AppRoute.assistantAssistanceCourseDetailPage,
            ),
          ),
        );

        return AssistanceStatusDialog(
          number: number,
          student: student,
        );
      },
    ).then((_) {
      if (_timer == null) return;

      if (_timer!.isActive) _timer!.cancel();
    });
  }
}
