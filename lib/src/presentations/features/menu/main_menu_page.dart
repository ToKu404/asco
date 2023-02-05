import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/assistance/assistance_page.dart';
import 'package:asco/src/presentations/features/menu/laboratory/laboratory_page.dart';
import 'package:asco/src/presentations/features/menu/leaderboard/leaderboard_page.dart';
import 'package:asco/src/presentations/features/menu/people/people_page.dart';
import 'package:asco/src/presentations/features/menu/profile/profile_page.dart';
import 'package:asco/src/presentations/widgets/side_menu_parent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/app_bar_title.dart';

void showStudentMainMenuPage({required BuildContext context}) {
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
  int _selectedIndex = 0;
  final _pages = [
    const StudentLaboratoryPage(),
    const StudentAssistancePage(),
    const LeaderboardPage(),
    Scaffold(
      backgroundColor: Palette.grey,
      body: Text(
        'Halaman 4',
        style: kTextTheme.displayLarge?.copyWith(color: Palette.black),
      ),
    ),
    const StudentPeoplePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SideMenuParent(
      onSelect: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      isShowBottomNav: _selectedIndex == -1 ? false : true,
      body: Builder(builder: (context) {
        if (_selectedIndex == -1) {
          return const StudentProfilePage();
        }
        return Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(),
          ),
          backgroundColor: Palette.grey,
          body: SafeArea(
            child: _pages[_selectedIndex],
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
