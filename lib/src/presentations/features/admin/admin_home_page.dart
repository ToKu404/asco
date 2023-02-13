import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/admin/attendance_page/attendance_classroom_page.dart';
import 'package:asco/src/presentations/features/admin/classroom_page/classroom_page.dart';
import 'package:asco/src/presentations/features/admin/practicum_page/practicum_page.dart';
import 'package:asco/src/presentations/features/admin/score_page/score_parcticum_page.dart';
import 'package:asco/src/presentations/features/admin/users_page/users_page.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:asco/src/presentations/widgets/inkwell_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showAdminHomePage({required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminHomePage(),
        settings: const RouteSettings(
          name: AppRoute.adminHomePage,
        ),
      ),
      (route) => false);
}

class AdminPageHelper {
  final String title;
  final IconData icon;
  final VoidCallback page;

  AdminPageHelper(this.title, this.icon, this.page);
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final listAdminPage = [
      AdminPageHelper(
        'Data Pengguna',
        Icons.person_2_rounded,
        () => showAdminUsersPage(context: context),
      ),
      AdminPageHelper(
        'Data Praktikum',
        Icons.class_rounded,
        () => showAdminPracticumPage(context: context),
      ),
      AdminPageHelper(
        'Data Kelas',
        Icons.meeting_room_rounded,
        () => showAdminClassroomPage(context: context),
      ),
      AdminPageHelper(
        'Data Absensi Pertemuan',
        Icons.task_alt_rounded,
        () => showAdminAttendanceClassroomPage(context: context),
      ),
      AdminPageHelper(
        'Data Nilai',
        Icons.score_rounded,
        () => showAdminScorePracticumPage(context: context),
      ),
      AdminPageHelper(
        'Data Asistensi',
        Icons.chat_bubble_rounded,
        () => showAdminUsersPage(context: context),
      ),
      AdminPageHelper(
        'Kartu Kontrol',
        Icons.card_membership_rounded,
        () => showAdminUsersPage(context: context),
      ),
      AdminPageHelper(
        'Data Tambahan Lab',
        Icons.settings_applications_rounded,
        () => showAdminUsersPage(context: context),
      ),
    ];

    return Scaffold(
      backgroundColor: Palette.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              const AppBarTitle(),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: AppSize.getAppWidth(context),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Palette.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AssetPath.getVector(
                        'logo2.svg',
                      ),
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Super Admin',
                            style: kTextTheme.bodyMedium
                                ?.copyWith(color: Palette.purple60),
                          ),
                          Text(
                            'Koordinator Lab',
                            style: kTextTheme.bodyLarge?.copyWith(
                              color: Palette.purple80,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Palette.purple60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showWelcomePage(context: context);
                      },
                      icon: SizedBox(
                        width: 16,
                        height: 16,
                        child: SvgPicture.asset(
                          AssetPath.getIcons('logout_outlined.svg'),
                          color: Palette.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listAdminPage.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return AdminMenuCard(adminPage: listAdminPage[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class AdminMenuCard extends StatelessWidget {
  const AdminMenuCard({
    super.key,
    required this.adminPage,
  });

  final AdminPageHelper adminPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.only(left: 4, top: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Palette.purple80,
            ),
          ),
        ),
        Positioned.fill(
          child: InkWellContainer(
            border: Border.all(width: 1, color: Palette.purple60),
            radius: 12,
            margin: const EdgeInsets.only(right: 4, bottom: 3),
            onTap: adminPage.page,
            color: Palette.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Palette.purple60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    adminPage.icon,
                    color: Palette.white,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  adminPage.title,
                  style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.purple80,
                      fontWeight: FontWeight.w600,
                      height: 1.05),
                  maxLines: 2,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
