import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/helpers/map_helper.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/detail_profile_entity.dart';
import 'package:asco/src/presentations/features/menu/laboratory/assistant/assistant_laboratory_quiz_value_input_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/attendance_dialog.dart';
import 'package:asco/src/presentations/features/menu/laboratory/widgets/mentor_tile.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';
import 'package:asco/src/presentations/widgets/custom_student_card.dart';
import 'package:asco/src/presentations/widgets/input_field/search_field.dart';
import 'package:asco/src/presentations/widgets/purple_app_bar.dart';
import 'package:asco/src/presentations/widgets/title_section.dart';

class AssistantLaboratoryCourseDetailPage extends StatefulWidget {
  final int meetingNumber;
  final DetailMeetingEntity meetingDetail;

  const AssistantLaboratoryCourseDetailPage({
    super.key,
    required this.meetingNumber,
    required this.meetingDetail,
  });

  @override
  State<AssistantLaboratoryCourseDetailPage> createState() =>
      _AssistantLaboratoryCourseDetailPageState();
}

class _AssistantLaboratoryCourseDetailPageState
    extends State<AssistantLaboratoryCourseDetailPage> {
  late final ValueNotifier<String> _queryNotifier;

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<ProfileNotifier>(context, listen: false).fetchMultiple(
        multipleId: <String>[
          widget.meetingDetail.assistant1Uid!,
          widget.meetingDetail.assistant2Uid!,
          ...widget.meetingDetail.attendances!
              .map((e) => e.studentUid!)
              .toList()
        ],
      ),
    );

    _queryNotifier = ValueNotifier('');
  }

  @override
  void dispose() {
    super.dispose();

    _queryNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, profileNotifier, child) {
        if (profileNotifier.isSuccessState('multiple')) {
          return _buildMainPage(
            context,
            assistant1: profileNotifier.listData
                .where((e) => e.uid == widget.meetingDetail.assistant1Uid!)
                .first,
            assistant2: profileNotifier.listData
                .where((e) => e.uid == widget.meetingDetail.assistant2Uid!)
                .first,
            students: profileNotifier.listData
                .where((e) =>
                    e.uid != widget.meetingDetail.assistant1Uid! &&
                    e.uid != widget.meetingDetail.assistant2Uid!)
                .toList()
              ..sort((a, b) => a.uid!.compareTo(b.uid!)),
            attendances: widget.meetingDetail.attendances!
              ..sort((a, b) => a.studentUid!.compareTo(b.studentUid!)),
          );
        }

        if (profileNotifier.isErrorState('multiple')) {
          return const Center(
            child: Text('unknown error occured'),
          );
        }

        return const AscoLoading(
          withScaffold: true,
        );
      },
    );
  }

  Scaffold _buildMainPage(
    BuildContext context, {
    required DetailProfileEntity assistant1,
    required DetailProfileEntity assistant2,
    required List<DetailProfileEntity> students,
    required List<AttendanceEntity> attendances,
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
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const TitleSection(title: 'Modul'),
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
                    const TitleSection(title: 'Quiz'),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: Palette.purple20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Buat Quiz'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              showAssistantLaboratoryQuizValueInputPage(
                                context,
                              );
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Palette.grey,
              surfaceTintColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight + 60),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const TitleSection(title: 'Absensi'),
                      ValueListenableBuilder(
                        valueListenable: _queryNotifier,
                        builder: (context, value, child) {
                          return SearchField(
                            text: value,
                            onChanged: (query) => _queryNotifier.value = query,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: students.length,
                  (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: buildStudentCard(
                        context,
                        students[index],
                        attendances[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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

  CustomStudentCard buildStudentCard(
    BuildContext context,
    DetailProfileEntity student,
    AttendanceEntity attendance,
  ) {
    return CustomStudentCard(
      student: student,
      hasAvatarBorder: true,
      // onTap: () => showDialog(
      //   context: context,
      //   barrierLabel: '',
      //   barrierDismissible: false,
      //   builder: (_) => AttendanceDialog(student: student),
      // ),
      isThreeLine: true,
      thirdLine: Text(
        _setStudentCardText(attendance),
        style: kTextTheme.bodySmall?.copyWith(
          color: Colors.grey,
        ),
      ),
      hasTrailing: true,
      trailing: _setStudentCardTrailing(attendance),
    );
  }

  String _setStudentCardText(AttendanceEntity attendance) {
    return attendance.attendanceStatus == null
        ? 'Belum absen'
        : attendance.attendanceStatus == 3
            ? 'Waktu absensi: ${ReusableHelper.dateTimeToString(
                attendance.attendanceTime!,
                isShowTime: true,
                format: 'HH:MM',
              )}'
            : '${MapHelper.getAttendanceStatus(attendance.attendanceStatus!)} ${attendance.note != null ? "(${attendance.note})" : ""}';
  }

  CircleBorderContainer _setStudentCardTrailing(AttendanceEntity attendance) {
    return attendance.attendanceStatus == null
        ? const CircleBorderContainer(size: 32)
        : attendance.attendanceStatus == 3
            ? const CircleBorderContainer(
                size: 32,
                borderColor: Palette.purple80,
                fillColor: Palette.purple60,
                child: Icon(
                  Icons.check_rounded,
                  size: 18,
                  color: Palette.white,
                ),
              )
            : const CircleBorderContainer(
                size: 32,
                borderColor: Color(0xFF8A6913),
                fillColor: Color(0xFFE4CC4B),
                child: Icon(
                  Icons.remove_rounded,
                  size: 18,
                  color: Palette.white,
                ),
              );
  }
}

void showAssistantLaboratoryCourseDetailPage(
  BuildContext context, {
  required int meetingNumber,
  required DetailMeetingEntity meetingDetail,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AssistantLaboratoryCourseDetailPage(
        meetingNumber: meetingNumber,
        meetingDetail: meetingDetail,
      ),
      settings: const RouteSettings(
        name: AppRoute.assistantLaboratoryCourseDetailPage,
      ),
    ),
  );
}
