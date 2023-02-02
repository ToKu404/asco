import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuHelper {
  final String title;
  final String unselectedIconPath;
  final String selectedIconPath;

  MenuHelper({
    required this.title,
    required this.unselectedIconPath,
    required this.selectedIconPath,
  });
}

class SideMenu extends StatefulWidget {
  final ValueNotifier<int> selectedIndex;
  const SideMenu({
    super.key,
    required this.selectedIndex,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final listMenu = [
    // MenuHelper(
    //   title: 'Beranda',
    //   unselectedIconPath: AssetPath.getIcons('home_outlined.svg'),
    //   selectedIconPath: AssetPath.getIcons('home_filled.svg'),
    // ),
    MenuHelper(
      title: 'Laboratorium',
      unselectedIconPath: AssetPath.getIcons('class_outlined.svg'),
      selectedIconPath: AssetPath.getIcons('class_filled.svg'),
    ),
    MenuHelper(
      title: 'Asistensi',
      unselectedIconPath: AssetPath.getIcons('assistance_outlined.svg'),
      selectedIconPath: AssetPath.getIcons('assistance_filled.svg'),
    ),
    MenuHelper(
      title: 'Leaderboard',
      unselectedIconPath: AssetPath.getIcons('leaderboard_outlined.svg'),
      selectedIconPath: AssetPath.getIcons('leaderboard_filled.svg'),
    ),
    MenuHelper(
      title: 'Extras',
      unselectedIconPath: AssetPath.getIcons('extras_outlined.svg'),
      selectedIconPath: AssetPath.getIcons('extras_filled.svg'),
    ),
    MenuHelper(
      title: 'People',
      unselectedIconPath: AssetPath.getIcons('people_outlined.svg'),
      selectedIconPath: AssetPath.getIcons('people_filled.svg'),
    ),
    // MenuHelper(
    //   title: 'Tentang',
    //   unselectedIconPath: AssetPath.getIcons('info_outlined.svg'),
    //   selectedIconPath: AssetPath.getIcons('info_filled.svg'),
    // ),
    // MenuHelper(
    //   title: 'Keluar',
    //   unselectedIconPath: AssetPath.getIcons('logout_outlined.svg'),
    //   selectedIconPath: AssetPath.getIcons('logout_outlined.svg'),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppSize.getAppWidth(context) * .7,
        height: double.infinity,
        color: Palette.blackPurple,
        child: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: widget.selectedIndex,
              builder: (context, value, _) {
                return Column(
                  children: [
                    const InfoCard(
                      title: 'ToKu404',
                      subtitle: 'Asisten',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 24,
                                top: 24,
                                bottom: 16,
                              ),
                              child: Text("JELAJAH",
                                  style: kTextTheme.subtitle2?.copyWith(
                                    color: Palette.disable,
                                  )),
                            ),
                            for (int i = 0; i < listMenu.length; i++)
                              SideMenuTile(
                                menu: listMenu[i],
                                press: () {
                                  widget.selectedIndex.value = i;
                                },
                                isActive: value == i,
                              ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     left: 24,
                            //     top: 24,
                            //     bottom: 16,
                            //   ),
                            //   child: Text(
                            //     "Lainnya",
                            //     style: kTextTheme.subtitle2?.copyWith(
                            //       color: Palette.disable,
                            //     ),
                            //   ),
                            // ),
                            // for (int i = listMenu.length - 2;
                            //     i < listMenu.length;
                            //     i++)
                            //   SideMenuTile(
                            //     menu: listMenu[i],
                            //     press: () {
                            //       widget.selectedIndex.value = i;
                            //     },
                            //     isActive: value == i,
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    Key? key,
    required this.menu,
    required this.press,
    required this.isActive,
  }) : super(key: key);

  final MenuHelper menu;
  final VoidCallback press;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: Divider(
            color: Palette.disable.withOpacity(.2),
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              height: 56,
              width: isActive ? AppSize.getAppWidth(context) * .7 - 8 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.purple60,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset(
                    isActive ? menu.selectedIconPath : menu.unselectedIconPath,
                    color: Palette.white,
                  )),
              title: Text(menu.title,
                  style: kTextTheme.subtitle2?.copyWith(color: Palette.white)),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const InfoCard({Key? key, required this.subtitle, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 16.0,
        right: 40,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Palette.greyDark,
              ),
              shape: BoxShape.circle,
              color: Palette.disable,
              image: DecorationImage(
                image: AssetImage(
                  AssetPath.getImage('avatar1.jpg'),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: kTextTheme.subtitle2?.copyWith(
                      color: Palette.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: kTextTheme.subtitle2?.copyWith(
                    color: Palette.white,
                    height: 1,
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
