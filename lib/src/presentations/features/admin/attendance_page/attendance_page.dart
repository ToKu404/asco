import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/attendance_page/widgets/attendance_card.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAdminAttendancePage(
    {required BuildContext context, required String classroomId}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AdminAttendancePage(
        classroomId: classroomId,
      ),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminAttendancePage extends StatefulWidget {
  final String classroomId;
  const AdminAttendancePage({super.key, required this.classroomId});

  @override
  State<AdminAttendancePage> createState() => _AdminAttendancePageState();
}

class _AdminAttendancePageState extends State<AdminAttendancePage> {
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
          'Data Absensi Kelas',
          style: kTextTheme.titleSmall?.copyWith(color: Palette.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: AppSize.getAppWidth(context),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.purple60,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.upload_file_rounded,
                    size: 20,
                    color: Palette.white,
                  ),
                  label: Text(
                    'Export ke Excel',
                    style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Builder(builder: (context) {
                final dataProvider = context.watch<MeetingNotifier>();

                // Todo : Add Shimmer
                if (dataProvider.isLoadingState('find')) {
                  return const SizedBox.shrink();
                } else if (dataProvider.isErrorState('find')) {
                  return const SizedBox.shrink();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AdminAttendanceCard(
                      entity: dataProvider.listData[index],
                      number: index + 1,
                    );
                  },
                  itemCount: dataProvider.listData.length,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
