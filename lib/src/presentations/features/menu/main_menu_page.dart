import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/features/menu/assistance/student/assistance_page.dart';
import 'package:asco/src/presentations/features/menu/extras/extras_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/assistant/assistant_laboratory_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/student/laboratory_page.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/student/leaderboard_page.dart';
import 'package:asco/src/presentations/features/menu/people/assistant/assistant_people_page.dart';
import 'package:asco/src/presentations/features/menu/people/student/people_page.dart';
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
import 'assistance/assistant/assitant_assitance_page.dart';
import 'leaderboard/assistant/assistant_leadeboard_page.dart';

void showMainMenuPage({required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MainMenuPage(),
        settings: const RouteSettings(
          name: AppRoute.studentMainMenuPage,
        ),
      ),
      (route) => false);
}

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
          Provider.of<AuthNotifier>(context, listen: false)..getUser(),
        });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userNotifier = context.watch<AuthNotifier>();

    if (userNotifier.getUserstate == RequestState.loading ||
        userNotifier.userCredentialEntity == null) {
      return const AscoLoading(
        withScaffold: true,
      );
    }
    final roleId = userNotifier.userCredentialEntity?.roleId;
    final pages = roleId == 1
        ? [
            const StudentLaboratoryPage(),
            const StudentAssistancePage(),
            const StudentLeaderboardPage(),
            const ExtrasPage(),
            const StudentPeoplePage(),
          ]
        : [
            const AssistantLaboratoryPage(),
            const AssistantAssistancePage(),
            const AssistantLeaderboardPage(),
            const ExtrasPage(),
            const AssistantPeoplePage(),
          ];
    return SideMenuParent(
      onSelect: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      isShowBottomNav: _selectedIndex == -1 ? false : true,
      body: Builder(builder: (context) {
        if (_selectedIndex == -1) {
          return roleId == 1
              ? const StudentProfilePage()
              : const AssistantProfilePage();
        } else if (_selectedIndex == 5) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            userNotifier.logOut();
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
            child: pages[_selectedIndex],
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
