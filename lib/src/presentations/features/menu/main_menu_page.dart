import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/presentations/features/home/home_page.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/student_assistance_page.dart';
import 'package:asco/src/presentations/features/menu/extras/extras_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/assistant/assistant_laboratory_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/student/student_laboratory_page.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/student/leaderboard_page.dart';
import 'package:asco/src/presentations/features/menu/people/people_page.dart';
import 'package:asco/src/presentations/features/menu/profile/assistant/assistant_profile_page.dart';
import 'package:asco/src/presentations/features/menu/profile/student/profile_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/side_menu/side_menu_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar_title.dart';
import 'assistance/assistant/assistant_assistance_page.dart';
import 'leaderboard/assistant/assistant_leadeboard_page.dart';

void showMainMenuPage(
    {required BuildContext context,
    required String classroomId,
    required String practicumId,
    required String groupId}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainMenuPage(
          classroomId: classroomId,
          groupId: groupId,
          practicumId: practicumId,
        ),
        settings: const RouteSettings(
          name: AppRoute.studentMainMenuPage,
        ),
      ),
      (route) => false);
}

class MainMenuPage extends StatefulWidget {
  final String classroomId;
  final String groupId;
  final String practicumId;
  const MainMenuPage(
      {super.key,
      required this.classroomId,
      required this.groupId,
      required this.practicumId});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<AuthNotifier>(context, listen: false)..getUser(),
        });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userNotifier = context.watch<AuthNotifier>();

    if (userNotifier.isLoadingState('single') || userNotifier.data == null) {
      return const AscoLoading(
        withScaffold: true,
      );
    }
    final roleId = userNotifier.data?.roleId;

    final pages = roleId == 1
        ? [
            StudentLaboratoryPage(
              classroomId: widget.classroomId,
            ),
            StudentAssistancePage(
              groupId: widget.groupId,
            ),
            const StudentLeaderboardPage(),
            const ExtrasPage(),
            PeoplePage(
              practicumUid: widget.practicumId,
            ),
          ]
        : [
            const AssistantLaboratoryPage(),
            const AssistantAssistancePage(),
            const AssistantLeaderboardPage(),
            const ExtrasPage(),
            PeoplePage(
              practicumUid: widget.practicumId,
            ),
          ];
    return SideMenuParent(
      onSelect: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      isShowBottomNav: _selectedIndex == -2 ? false : true,
      body: Builder(builder: (context) {
        if (_selectedIndex == -2) {
          return roleId == 1
              ? const StudentProfilePage()
              : const AssistantProfilePage();
        } else if (_selectedIndex == -1) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Future.delayed(const Duration(milliseconds: 500), () {
              showHomePage(context: context, roleId: roleId!);
            });
          });
          return const Scaffold(
            body: SizedBox.shrink(),
          );
        } else if (_selectedIndex == 5) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            userNotifier.logout();
            showWelcomePage(context: context);
          });
          return const Scaffold(
            body: SizedBox.shrink(),
          );
        }
        return Scaffold(
          appBar: _selectedIndex == 2
              ? AppBar(
                  backgroundColor: Palette.purple80,
                  leading: const SizedBox.shrink(),
                )
              : AppBar(
                  title: const AppBarTitle(),
                ),
          backgroundColor: Palette.grey,
          body: SafeArea(
            child: IndexedStack(
              index: _selectedIndex,
              children: pages,
            ),
          ),
        );
      }),
    );
  }
}

class TabIcon extends StatelessWidget {
  final String selectedIconPath;
  final String unselectedIconPath;
  final bool isActive;
  final VoidCallback onPress;
  const TabIcon(
      {super.key,
      required this.isActive,
      required this.selectedIconPath,
      required this.onPress,
      required this.unselectedIconPath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 5,
              width: isActive ? 24 : 0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.purple60,
              ),
            ),
            Expanded(
                child: Center(
              child: SizedBox(
                width: 22,
                child: SvgPicture.asset(
                  isActive ? selectedIconPath : unselectedIconPath,
                  color: isActive ? Palette.purple60 : Palette.grey,
                ),
              ),
            )),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
