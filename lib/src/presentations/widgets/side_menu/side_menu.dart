import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
  final ValueNotifier<int?> selectedIndex;
  final Function(int)? onSelect;
  final bool isMainMenu;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    required this.isMainMenu,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileNotifier>(context, listen: false).getSelfDetail();
    });
  }

  final listMenu = [
    MenuHelper(
      title: 'Beranda',
      unselectedIconPath: AssetPath.getIcon('home_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('home_filled.svg'),
    ),
    MenuHelper(
      title: 'Laboratorium',
      unselectedIconPath: AssetPath.getIcon('class_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('class_filled.svg'),
    ),
    MenuHelper(
      title: 'Asistensi',
      unselectedIconPath: AssetPath.getIcon('assistance_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('assistance_filled.svg'),
    ),
    MenuHelper(
      title: 'Leaderboard',
      unselectedIconPath: AssetPath.getIcon('leaderboard_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('leaderboard_filled.svg'),
    ),
    MenuHelper(
      title: 'Extras',
      unselectedIconPath: AssetPath.getIcon('extras_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('extras_filled.svg'),
    ),
    MenuHelper(
      title: 'People',
      unselectedIconPath: AssetPath.getIcon('people_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('people_filled.svg'),
    ),
    // MenuHelper(
    //   title: 'Tentang',
    //   unselectedIconPath: AssetPath.getIcons('info_outlined.svg'),
    //   selectedIconPath: AssetPath.getIcons('info_filled.svg'),
    // ),
    MenuHelper(
      title: 'Keluar',
      unselectedIconPath: AssetPath.getIcon('logout_outlined.svg'),
      selectedIconPath: AssetPath.getIcon('logout_outlined.svg'),
    ),
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
                    Builder(builder: (context) {
                      final userNotifier = context.watch<ProfileNotifier>();
                      final profile = userNotifier.data;

                      return GestureDetector(
                        onTap: () {
                          widget.selectedIndex.value = -2;
                          widget.onSelect!(-2);
                        },
                        child: UserProfileCard(
                          title: profile != null ? profile.nickName! : '',
                          subtitle:
                              profile != null ? profile.userRole!.name! : '',
                        ),
                      );
                    }),
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
                              child: Text("MENU",
                                  style: kTextTheme.bodyLarge?.copyWith(
                                    color: Palette.disable,
                                  )),
                            ),
                            SideMenuTile(
                              menu: listMenu[0],
                              press: () {
                                widget.selectedIndex.value = 0 - 1;
                                widget.onSelect!(0 - 1);
                              },
                              isActive: value == 0 - 1,
                            ),
                            if (widget.isMainMenu)
                              for (int i = 1; i < listMenu.length - 1; i++)
                                SideMenuTile(
                                  menu: listMenu[i],
                                  press: () {
                                    widget.selectedIndex.value = i - 1;
                                    widget.onSelect!(i - 1);
                                  },
                                  isActive: value == i - 1,
                                ),
                            if (widget.isMainMenu)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 24,
                                  top: 24,
                                  bottom: 16,
                                ),
                                child: Text(
                                  "LAINNYA",
                                  style: kTextTheme.bodyLarge?.copyWith(
                                    color: Palette.disable,
                                  ),
                                ),
                              ),
                            for (int i = listMenu.length - 1;
                                i < listMenu.length;
                                i++)
                              SideMenuTile(
                                menu: listMenu[i],
                                press: () {
                                  widget.selectedIndex.value = i - 1;
                                  widget.onSelect!(i - 1);
                                },
                                isActive: value == i - 1,
                              ),
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
                  style: kTextTheme.bodyLarge?.copyWith(color: Palette.white)),
            ),
          ],
        ),
      ],
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const UserProfileCard({Key? key, required this.subtitle, required this.title})
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
                  style: kTextTheme.bodyLarge?.copyWith(
                      color: Palette.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: kTextTheme.bodyLarge?.copyWith(
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
