import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_practicum_page.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/widgets/input_field/input_time_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAdminMeetingDetailPage({
  required BuildContext context,
  required DetailMeetingEntity meetingEntity,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MeetingDetailPage(
        meeting: meetingEntity,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class MeetingDetailPage extends StatefulWidget {
  final DetailMeetingEntity meeting;
  const MeetingDetailPage({
    super.key,
    required this.meeting,
  });

  @override
  State<MeetingDetailPage> createState() => _MeetingDetailPageState();
}

class _MeetingDetailPageState extends State<MeetingDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ClassroomNotifier>(context, listen: false)
        ..getDetail(
          uid: widget.meeting.classUid!,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classNotifier = context.watch<ClassroomNotifier>();
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        backgroundColor: Palette.purple80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Palette.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showAdminCreatePracticumPage(context: context, isEdit: true);
            },
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Palette.white,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: AppSize.getAppWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.white,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Materi',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      widget.meeting.topic ?? '',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Tanggal Pertemuan',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      widget.meeting.meetingDate != null
                          ? ReusableHelper.datetimeToString(
                              widget.meeting.meetingDate!)
                          : '',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pukul',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      classNotifier.data != null
                          ? '${ReusableHelper.timeFormater(TimeHelper(
                              startHour: classNotifier.data?.startHour,
                              endHour: classNotifier.data?.endHour,
                              startMinute: classNotifier.data?.startMinute,
                              endMinute: classNotifier.data?.endMinute,
                            ))} WITA'
                          : '...',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pemateri',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      widget.meeting.assistant1 != null
                          ? widget.meeting.assistant1!.fullName!
                          : '-',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pendamping',
                      style: kTextTheme.titleSmall?.copyWith(
                        color: Palette.black,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      widget.meeting.assistant2 != null
                          ? widget.meeting.assistant2!.fullName!
                          : '-',
                      style: kTextTheme.titleMedium?.copyWith(
                        color: Palette.blackPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
