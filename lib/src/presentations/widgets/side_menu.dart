import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

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
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final listMenu = [
    MenuHelper(
      title: 'Beranda',
      unselectedIconPath: AssetPath.getIcons('home_outlined.svg'),
      selectedIconPath: AssetPath.getIcons('home_filled.svg'),
    ),
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
  ];

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<MenuHelper> selectedMenu =
        ValueNotifier(listMenu.first);
    return Scaffold(
      body: Container(
        width: AppSize.getAppWidth(context) * .7,
        height: double.infinity,
        color: Palette.blackPurple,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                title: 'ToKu404',
                subtitle: 'Asisten',
              ),
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
              ValueListenableBuilder(
                  valueListenable: selectedMenu,
                  builder: (context, value, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...listMenu.map((menu) {
                          return SideMenuTile(
                            menu: menu,
                            press: () {
                              selectedMenu.value = menu;
                            },
                            isActive: value == menu,
                          );
                        }).toList()
                      ],
                    );
                  }),
            ],
          ),
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
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
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
      title: Text(
        title,
        style: kTextTheme.subtitle2
            ?.copyWith(color: Palette.white, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: kTextTheme.subtitle2?.copyWith(
          color: Palette.white,
          height: 1,
        ),
      ),
    );
  }
}
