import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/helpers/reusable_helper.dart';
import 'package:asco/src/domain/entities/assistance_entities/assistance_group_entity.dart';
import 'package:asco/src/domain/entities/meeting_entities/meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistant/assistant_assistance_course_detail_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistant/assistant_assistance_practitioner_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/control_card.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/github_dialog.dart';
import 'package:asco/src/presentations/features/menu/assistance/widgets/student_avatar.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/circle_network_image.dart';

class AssistantAssistancePage extends StatefulWidget {
  final String practicumId;
  final String classroomId;
  final String groupId;

  const AssistantAssistancePage({
    super.key,
    required this.practicumId,
    required this.classroomId,
    required this.groupId,
  });

  @override
  State<AssistantAssistancePage> createState() =>
      _AssistantAssistancePageState();
}

class _AssistantAssistancePageState extends State<AssistantAssistancePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AssistanceNotifier>(context, listen: false)
          .getDetail(uuid: widget.groupId);

      Provider.of<MeetingNotifier>(context, listen: false)
          .fetch(classroomUid: widget.classroomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AssistanceNotifier>(
      builder: (context, assistanceNotifier, child) {
        if (assistanceNotifier.isSuccessState('single')) {
          return buildMainPage(
            context,
            assistanceGroup: assistanceNotifier.data,
          );
        }

        if (assistanceNotifier.isErrorState('single')) {
          return const Center(
            child: Text('unknown error occured'),
          );
        }

        return const AscoLoading();
      },
    );
  }

  Scaffold buildMainPage(
    BuildContext context, {
    required AssistanceGroupEntity? assistanceGroup,
  }) {
    final students = assistanceGroup?.students ?? <ProfileEntity>[];

    return Scaffold(
      backgroundColor: Palette.grey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Palette.purple80,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: RotatedBox(
                            quarterTurns: -2,
                            child: SvgPicture.asset(
                              AssetPath.getVector('bg_attribute.svg'),
                              width: AppSize.getAppWidth(context) / 3,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          child: Text(
                            'Group Asistensi ${assistanceGroup?.name}',
                            style: kTextTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: SvgPicture.asset(
                              AssetPath.getVector('bg_attribute.svg'),
                              width: AppSize.getAppWidth(context) / 3,
                              color: Palette.disable.withOpacity(.4),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
                          child: ListTile(
                            horizontalTitleGap: 12,
                            leading: CircleNetworkImage(
                              width: 56,
                              height: 56,
                              imgUrl:
                                  '${assistanceGroup?.assistant?.profilePhoto}',
                              placeholderSize: 20,
                              errorIcon: Icons.person_rounded,
                              withBorder: true,
                              borderWidth: 2,
                              borderColor: Palette.purple60,
                            ),
                            title: Text(
                              'Asisten',
                              style: kTextTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Palette.purple60,
                              ),
                            ),
                            subtitle: Text(
                              '${assistanceGroup?.assistant?.fullName}',
                              style: kTextTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Palette.purple100,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: Palette.purple80,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      ReusableHelper.onPressedSocialMediaIcon(
                                        context,
                                        isAvailable:
                                            assistanceGroup!.github!.isNotEmpty,
                                        uri: assistanceGroup.github!,
                                        socialMedia: 'Github',
                                        title: 'Repository Tidak Ada',
                                        message:
                                            'Anda belum mengisi link repository Github',
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      AssetPath.getIcon('github_filled.svg'),
                                      width: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () => showDialog(
                                      context: context,
                                      barrierLabel: '',
                                      barrierDismissible: false,
                                      builder: (_) => const GithubDialog(),
                                    ),
                                    child: SvgPicture.asset(
                                      AssetPath.getIcon('edit.svg'),
                                      width: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Praktikan',
                        style: kTextTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.purple100,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<ProfileNotifier>().reset();

                          showAssistantAssistancePractitionerPage(
                            context,
                            practicumId: widget.practicumId,
                          );
                        },
                        child: Text(
                          'Lihat Detail',
                          style: kTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Palette.purple60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, i) => StudentAvatar(student: students[i]),
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemCount: students.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 16,
              ),
              child: Consumer<MeetingNotifier>(
                builder: (context, meetingNotifier, child) {
                  if (meetingNotifier.isLoadingState('find')) {
                    return const AscoLoading();
                  }

                  if (meetingNotifier.isErrorState('find')) {
                    return Center(
                      child: Text(meetingNotifier.message),
                    );
                  }

                  final meetingData = meetingNotifier.listData;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Kartu Kontrol',
                            style: kTextTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.purple100,
                            ),
                          ),
                          Text(
                            '${meetingData.length} Materi',
                            style: kTextTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Palette.purple60,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...meetingData.map((data) {
                        return buildControlCard(
                          context,
                          meeting: MeetingEntity.fromDetail(data),
                          students: students,
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ControlCard buildControlCard(
    BuildContext context, {
    required MeetingEntity meeting,
    required List<ProfileEntity> students,
  }) {
    return ControlCard(
      meeting: meeting,
      verticalAlignment: CrossAxisAlignment.start,
      isThreeLine: true,
      thirdLine: const AssistanceStatistics(),
      onTap: () => showAssistantAssistanceCourseDetailPage(
        context,
        title: meeting.topic ?? '',
        students: students,
        meetingNumber: meeting.meetingNumber!,
      ),
    );
  }
}

class AssistanceStatistics extends StatelessWidget {
  const AssistanceStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [8, 4];

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            if (data[0] != 0) ...[
              Expanded(
                flex: data[0],
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.purple60,
                  ),
                ),
              ),
            ],
            if (data[1] != 0) ...[
              const SizedBox(width: 4),
              Expanded(
                flex: data[1],
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFFA78A6),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            AssistanceDataStatus(
              value: data[0],
              assistanceStatus: AssistanceStatus.done,
            ),
            const SizedBox(width: 6),
            AssistanceDataStatus(
              value: data[1],
              assistanceStatus: AssistanceStatus.undone,
            ),
          ],
        )
      ],
    );
  }
}

class AssistanceDataStatus extends StatelessWidget {
  final int value;
  final AssistanceStatus assistanceStatus;

  const AssistanceDataStatus({
    super.key,
    required this.value,
    required this.assistanceStatus,
  });

  @override
  Widget build(BuildContext context) {
    final Map<AssistanceStatus, AssistanceData> data = {
      AssistanceStatus.done: AssistanceData(
        title: 'Selesai',
        color: Palette.purple60,
      ),
      AssistanceStatus.undone: AssistanceData(
        title: 'Belum',
        color: Palette.plum60,
      ),
    };

    return Text(
      '$value ${data[assistanceStatus]!.title}',
      style: kTextTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: data[assistanceStatus]!.color,
      ),
    );
  }
}

class AssistanceData {
  final String title;
  final Color color;

  AssistanceData({
    required this.title,
    required this.color,
  });
}

enum AssistanceStatus { done, undone }
