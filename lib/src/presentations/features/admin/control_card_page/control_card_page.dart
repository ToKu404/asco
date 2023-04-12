import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'control_card_list_page.dart';

void showAdminControlCardPage({
  required BuildContext context,
  required String practicumUid,
  required String courseName,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminControlCardPage(
        practicumUid: practicumUid,
        courseName: courseName,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminControlCardPage extends StatefulWidget {
  final String practicumUid;
  final String courseName;

  const AdminControlCardPage({
    super.key,
    required this.practicumUid,
    required this.courseName,
  });

  @override
  State<AdminControlCardPage> createState() => _AdminControlCardPageState();
}

class _AdminControlCardPageState extends State<AdminControlCardPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileNotifier>(context, listen: false)
          .fetchAll(practicumUid: widget.practicumUid);
    });
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
          widget.courseName,
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  hintText: 'Cari nim atau nama lengkap',
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
                          AssetPath.getIcon('search_outlined.svg'),
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
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Builder(builder: (context) {
                final profileNotifier = context.watch<ProfileNotifier>();

                // Todo : Add Shimmer
                if (profileNotifier.isLoadingState('find')) {
                  return const SizedBox.shrink();
                } else if (profileNotifier.isErrorState('find')) {
                  return const SizedBox.shrink();
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16 + 65,
                  ),
                  itemBuilder: (context, index) {
                    final student = profileNotifier.listData[index];
                    return StudentCard(
                      classCode: student.userPracticums != null &&
                              student.userPracticums?[widget.practicumUid] !=
                                  null &&
                              student.userPracticums?[widget.practicumUid]
                                      ?.classroom !=
                                  null
                          ? student.userPracticums![widget.practicumUid]!
                              .classroom!.classCode
                          : null,
                      groupName: student.userPracticums != null &&
                              student.userPracticums?[widget.practicumUid] !=
                                  null &&
                              student.userPracticums?[widget.practicumUid]
                                      ?.group !=
                                  null
                          ? student
                              .userPracticums![widget.practicumUid]!.group!.name
                          : null,
                      fullname: student.fullName,
                      username: student.username,
                      uid: student.uid,
                      classroomUid: student.userPracticums != null
                          ? student.userPracticums![widget.practicumUid]
                              ?.classroom?.uid!
                          : null,
                    );
                  },
                  itemCount: profileNotifier.listData.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentCard extends StatefulWidget {
  final String? classCode;
  final String? groupName;
  final String? username;
  final String? fullname;
  final String? classroomUid;
  final String? uid;
  const StudentCard({
    super.key,
    this.classCode,
    this.groupName,
    required this.classroomUid,
    required this.fullname,
    required this.username,
    required this.uid,
  });

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Palette.white,
      onTap: () {
        showAdminListControlCardPage(
          context: context,
          studentId: widget.uid ?? "",
          studentName: widget.fullname ?? "",
          classroomUid: widget.classroomUid ?? '',
        );
      },
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 12),
      radius: 12,
      child: ListTile(
        leading: const Avatar(imageAsset: 'avatar1.jpg'),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                widget.username ?? '',
                style: kTextTheme.bodyMedium?.copyWith(
                  color: Palette.purple60,
                ),
              ),
            ),
            Flexible(
              child: Text(
                widget.fullname ?? '',
                style: kTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                if (widget.classCode != null) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.purple60,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Kelas ${widget.classCode}',
                      style: kTextTheme.bodySmall?.copyWith(
                        color: Palette.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                ],
                if (widget.groupName != null)
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.purple60,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Group #${widget.groupName}',
                      style: kTextTheme.bodySmall?.copyWith(
                        color: Palette.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final String imageAsset;

  const Avatar({
    super.key,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Palette.white,
      ),
      padding: const EdgeInsets.all(2.0),
      child: CircleAvatar(
        radius: 28,
        foregroundImage: AssetImage(
          AssetPath.getImage(imageAsset),
        ),
      ),
    );
  }
}
