import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/class_student_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/create_practicum_page.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/widgets/input_field/input_time_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAdminClassDetailPage({
  required BuildContext context,
  required String classroomUid,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ClassDetailPage(
        classroomUid: classroomUid,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class ClassDetailPage extends StatefulWidget {
  final String classroomUid;
  const ClassDetailPage({
    super.key,
    required this.classroomUid,
  });

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ClassroomNotifier>(context, listen: false)
        ..getDetail(
          uid: widget.classroomUid,
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
        actions: [
          IconButton(
            onPressed: () {
              showAdminCreatePracticumPage(context: context, isEdit: true);
            },
            icon: const Icon(
              Icons.edit_rounded,
              color: Palette.white,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Builder(builder: (context) {
          final dataProvider = context.watch<ClassroomNotifier>();

          if (dataProvider.isLoadingState('single') ||
              dataProvider.data == null) {
            return const SizedBox.shrink();
          } else if (dataProvider.isErrorState('single')) {
            return const SizedBox.shrink();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppSize.getAppWidth(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Palette.white),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Kelas',
                        style: kTextTheme.titleSmall?.copyWith(
                          color: Palette.black,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        'Kelas ${dataProvider.data?.classCode}',
                        style: kTextTheme.titleMedium?.copyWith(
                          color: Palette.blackPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Setiap Hari',
                        style: kTextTheme.titleSmall?.copyWith(
                          color: Palette.black,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        'Kelas ${dataProvider.data?.meetingDay}',
                        style: kTextTheme.titleMedium?.copyWith(
                          color: Palette.blackPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Pukul',
                        style: kTextTheme.titleSmall?.copyWith(
                          color: Palette.black,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        ReusableHelper.timeFormater(TimeHelper(
                          startHour: dataProvider.data?.startHour,
                          endHour: dataProvider.data?.endHour,
                          startMinute: dataProvider.data?.startMinute,
                          endMinute: dataProvider.data?.endMinute,
                        )),
                        style: kTextTheme.titleMedium?.copyWith(
                          color: Palette.blackPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                _StudentsSection(
                  classroomUid: widget.classroomUid,
                  students: dataProvider.data!.students!,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _StudentsSection extends StatefulWidget {
  final String classroomUid;
  final List<ProfileEntity> students;

  const _StudentsSection({
    required this.classroomUid,
    required this.students,
  });

  @override
  State<_StudentsSection> createState() => _StudentsSectionState();
}

class _StudentsSectionState extends State<_StudentsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${widget.students.length}',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.purple70,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Mahasiswa',
              style: kTextTheme.titleSmall?.copyWith(
                color: Palette.black,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 30,
              height: 30,
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Palette.purple70,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                ),
                onPressed: () {
                  showAdminClassStudentPage(
                    context: context,
                    students: widget.students,
                    classroomUid: widget.classroomUid,
                  );
                },
                icon: const Icon(
                  Icons.add_rounded,
                  color: Palette.white,
                ),
              ),
            ),
          ],
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return UserCard(
              user: widget.students[index],
            );
          },
          itemCount: widget.students.length,
        )
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  final ProfileEntity user;
  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: AppSize.getAppWidth(context),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(AssetPath.getImage('avatar1.jpg')),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.username ?? '',
                  style: kTextTheme.bodyMedium?.copyWith(
                    color: Palette.purple60,
                  ),
                ),
                Text(
                  user.fullName ?? '',
                  style: kTextTheme.bodyLarge?.copyWith(
                    color: Palette.purple80,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
