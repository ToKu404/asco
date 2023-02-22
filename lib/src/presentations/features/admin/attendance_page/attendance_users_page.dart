import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/attendance_entities/attendance_entity.dart';
import 'package:asco/src/domain/entities/profile_entities/profile_entity.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:asco/src/presentations/widgets/circle_border_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminAttendanceUsersPage(
    {required BuildContext context,
    required int number,
    required List<AttendanceEntity> attendances}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminAttendanceUserPage(
        attendances: attendances,
        number: number,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminAttendanceUserPage extends StatefulWidget {
  final List<AttendanceEntity> attendances;
  final int number;
  const AdminAttendanceUserPage({
    super.key,
    required this.attendances,
    required this.number,
  });

  @override
  State<AdminAttendanceUserPage> createState() =>
      _AdminAttendanceUserPageState();
}

class _AdminAttendanceUserPageState extends State<AdminAttendanceUserPage> {
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
      () => Provider.of<ProfileNotifier>(context, listen: false)
        ..fetchMultiple(
            multipleId: widget.attendances.map((e) => e.studentUid!).toList()),
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
          'Pertemuan ${widget.number}',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
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
                  hintText: 'Cari nama atau nim',
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
                  final dataProvider = context.watch<ProfileNotifier>();

                  // Todo : Add Shimmer
                  if (dataProvider.isLoadingState('multiple')) {
                    return const SizedBox.shrink();
                  } else if (dataProvider.isErrorState('multiple')) {
                    return const SizedBox.shrink();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    itemBuilder: (context, index) {
                      try {
                        return CustomStudentCard(
                          attendance: widget.attendances.firstWhere((element) =>
                              element.studentUid ==
                              dataProvider.listData[index].uid),
                          student: ProfileEntity.fromDetail(
                              dataProvider.listData[index]),
                        );
                      } catch (e) {
                        return const SizedBox.shrink();
                      }
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

class CustomStudentCard extends StatelessWidget {
  final ProfileEntity student;
  final AttendanceEntity attendance;

  const CustomStudentCard({
    super.key,
    required this.student,
    required this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Palette.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              radius: 28,
              backgroundColor: Palette.purple80,
              child: Hero(
                tag: student,
                child: CircleAvatar(
                  radius: 28,
                  foregroundImage: AssetImage(
                    AssetPath.getImage('avatar1.jpg'),
                  ),
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
                    student.username ?? '',
                    style: kTextTheme.bodyMedium?.copyWith(
                      color: Palette.purple60,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    student.fullName ?? '',
                    style: kTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Palette.purple80,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    attendance.attendanceStatus == 0
                        ? 'Waktu absensi: ${ReusableHelper.datetimeToString(attendance.attendanceTime!)}'
                        : attendance.note ?? '',
                    style: kTextTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const CircleBorderContainer(
              size: 30,
              borderColor: Palette.purple80,
              fillColor: Palette.purple60,
              child: Icon(
                Icons.check_rounded,
                size: 16,
                color: Palette.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
