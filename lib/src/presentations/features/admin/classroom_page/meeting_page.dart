import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/meeting_entities/detail_meeting_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/admin/classroom_page/create_meeting_page.dart';
import 'package:asco/src/presentations/features/admin/classroom_page/meeting_detail_page.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminClassroomMeetingPage({
  required BuildContext context,
  required String classroomId,
  required List<ProfileEntity> students,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminClassroomMeetingPage(
        classroomId: classroomId,
        students: students,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminClassroomMeetingPage extends StatefulWidget {
  final String classroomId;
  final List<ProfileEntity> students;
  const AdminClassroomMeetingPage({
    super.key,
    required this.classroomId,
    required this.students,
  });

  @override
  State<AdminClassroomMeetingPage> createState() =>
      _AdminClassroomMeetingPageState();
}

class _AdminClassroomMeetingPageState extends State<AdminClassroomMeetingPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MeetingNotifier>(context, listen: false)
        ..fetch(
          classroomUid: widget.classroomId,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'Data Pertemuan',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.blackPurple,
          shape: const CircleBorder(
              side: BorderSide(width: 1, color: Palette.purple60)),
          child: const Icon(
            Icons.add_rounded,
            color: Palette.white,
          ),
          onPressed: () {
            showAdminCreateMeetingPage(
              context: context,
              classroomUid: widget.classroomId,
              students: widget.students,
            );
          }),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: (value) {},
                keyboardType: TextInputType.text,
                style: kTextTheme.bodyLarge?.copyWith(
                  color: Palette.blackPurple,
                ),
                cursorColor: Palette.blackPurple,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: 'Cari Materi',
                  hintStyle:
                      kTextTheme.bodyLarge?.copyWith(color: Palette.disable),
                  filled: true,
                  prefixIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: SvgPicture.asset(
                          AssetPath.getIcons('search_outlined.svg'),
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ],
                  ),
                  prefixIconColor: Palette.blackPurple,
                  fillColor: Palette.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.blackPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Palette.blackPurple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final dataProvider = context.watch<MeetingNotifier>();

                  // Todo : Add Shimmer
                  if (dataProvider.isLoadingState('find')) {
                    return const SizedBox.shrink();
                  } else if (dataProvider.isErrorState('find')) {
                    return const SizedBox.shrink();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16 + 65,
                    ),
                    itemBuilder: (context, index) {
                      return MeetingCard(
                        meeting: dataProvider.listData[index],
                        onTap: () {
                          showAdminMeetingDetailPage(
                            context: context,
                            meetingEntity: dataProvider.listData[index],
                            
                          );
                        },
                        meetingNumber: index + 1,
                      );
                    },
                    itemCount: dataProvider.listData.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingCard extends StatelessWidget {
  final DetailMeetingEntity meeting;
  final int meetingNumber;

  final VoidCallback? onTap;

  const MeetingCard({
    super.key,
    required this.meeting,
    required this.meetingNumber,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Palette.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Palette.purple80,
                  child: Text(
                    '#$meetingNumber',
                    style: kTextTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Palette.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        meeting.topic ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palette.purple100,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meeting.meetingDate != null
                            ? ReusableHelper.datetimeToString(
                                meeting.meetingDate!)
                            : '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kTextTheme.bodyMedium?.copyWith(
                          color: Palette.purple60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
