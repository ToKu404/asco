import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/user_helper.dart';
import 'package:asco/src/domain/entities/classroom_entities/classroom_entity.dart';
import 'package:asco/src/presentations/features/admin/classroom_page/meeting_page.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:asco/src/presentations/widgets/input_field/input_time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showAdminClassroomPage({required BuildContext context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminClassroomPage(),
      settings: const RouteSettings(
        name: AppRoute.adminUsersPage,
      ),
    ),
  );
}

class AdminClassroomPage extends StatefulWidget {
  const AdminClassroomPage({super.key});

  @override
  State<AdminClassroomPage> createState() => _AdminClassroomPageState();
}

class _AdminClassroomPageState extends State<AdminClassroomPage> {
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
      () => Provider.of<ClassroomNotifier>(context, listen: false)..fetch(),
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
          'Data Kelas',
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
                  hintText: 'Cari nama praktikum',
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
              child: Builder(builder: (context) {
                final dataProvider = context.watch<ClassroomNotifier>();

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
                    return PracticumClassCard(
                      classroom: dataProvider.listData[index],
                    );
                  },
                  itemCount: dataProvider.listData.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class PracticumClassCard extends StatelessWidget {
  final ClassroomEntity classroom;
  const PracticumClassCard({
    super.key,
    required this.classroom,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellContainer(
      color: Colors.white,
      onTap: () {
        showAdminClassroomMeetingPage(context: context);
      },
      radius: 12,
      child: Container(
        width: AppSize.getAppWidth(context),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${classroom.courseName}',
              style: kTextTheme.bodyMedium?.copyWith(
                color: Palette.purple80,
                height: 1.2,
              ),
            ),
            Text(
              'Kelas ${classroom.classCode}',
              style: kTextTheme.bodyLarge?.copyWith(
                color: Palette.purple80,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Setiap ${classroom.meetingDay} ${UserHelper.timeFormater(TimeHelper(
                startHour: classroom.startHour,
                endHour: classroom.endHour,
                startMinute: classroom.startMinute,
                endMinute: classroom.endMinute,
              ))}',
              style: kTextTheme.bodyMedium?.copyWith(
                color: Palette.purple60,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
