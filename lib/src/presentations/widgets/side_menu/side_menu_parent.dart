import 'dart:math';
import 'package:asco/core/helpers/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/helpers/app_size.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/menu/main_menu_page.dart';
import 'package:asco/src/presentations/widgets/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideMenuParent extends StatefulWidget {
  final Widget body;
  final Function(int)? onSelect;
  final bool isMainMenu;
  final bool isShowBottomNav;
  const SideMenuParent({
    super.key,
    required this.body,
    this.isMainMenu = true,
    this.isShowBottomNav = true,
    this.onSelect,
  });

  @override
  State<SideMenuParent> createState() => _SideMenuParentState();
}

class _SideMenuParentState extends State<SideMenuParent>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> isSideMenuClosed = ValueNotifier(true);
  final ValueNotifier<int?> _selectedIndex = ValueNotifier(null);

  @override
  void dispose() {
    super.dispose();
    isSideMenuClosed.dispose();
    _selectedIndex.dispose();
  }

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> radiusAnimation;
  late Animation<double> scaleAnimation;
  bool isDragging = false;

  @override
  void initState() {
    _selectedIndex.value = widget.isMainMenu ? 0 : -1;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    radiusAnimation = Tween<double>(begin: 0, end: 16).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (context, selectValue, _) {
          return Scaffold(
            backgroundColor: Palette.blackPurple,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: SafeArea(
              child: ValueListenableBuilder(
                  valueListenable: isSideMenuClosed,
                  builder: (context, value, _) {
                    return WillPopScope(
                      onWillPop: () async {
                        if (!value) {
                          _animationController.reverse();
                          isSideMenuClosed.value = true;
                          return false;
                        }
                        return true;
                      },
                      child: GestureDetector(
                        onHorizontalDragStart: (details) => isDragging = true,
                        onHorizontalDragUpdate: (details) {
                          if (!isDragging && isSideMenuClosed.value) return;
                          const delta = 1;
                          if (details.delta.dx < -delta) {
                            _animationController.reverse();
                            isSideMenuClosed.value = true;
                          } else if (details.delta.dx > delta) {
                            _animationController.forward();
                            isSideMenuClosed.value = false;
                          }
                          isDragging = false;
                        },
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastOutSlowIn,
                              width: AppSize.getAppWidth(context) * .7,
                              left: value
                                  ? -AppSize.getAppWidth(context) * .7
                                  : 0,
                              height: MediaQuery.of(context).size.height,
                              child: SideMenu(
                                onSelect: widget.onSelect,
                                selectedIndex: _selectedIndex,
                                isMainMenu: widget.isMainMenu,
                              ),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(
                                  3,
                                  2,
                                  0.001,
                                )
                                ..rotateY(animation.value -
                                    30 * animation.value * pi / 180),
                              child: Transform.translate(
                                offset: Offset(
                                    animation.value *
                                        (AppSize.getAppWidth(context) * .7 -
                                            15),
                                    0),
                                child: Transform.scale(
                                  scale: scaleAnimation.value,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: isSideMenuClosed.value &&
                                            widget.isShowBottomNav
                                        ? const EdgeInsets.only(bottom: 57)
                                        : EdgeInsets.zero,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          radiusAnimation.value),
                                      child: AbsorbPointer(
                                          absorbing: isSideMenuClosed.value
                                              ? false
                                              : true,
                                          child: widget.body),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              left: value
                                  ? 0
                                  : AppSize.getAppWidth(context) * .7 - 40,
                              curve: Curves.fastOutSlowIn,
                              top: 12,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (value) {
                                      _animationController.forward();
                                      isSideMenuClosed.value = false;
                                    } else {
                                      _animationController.reverse();
                                      isSideMenuClosed.value = true;
                                    }
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(8.0),
                                    height: 36,
                                    width: 36,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 3),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                      value
                                          ? AssetPath.getIcon('hamburger.svg')
                                          : AssetPath.getIcon('close.svg'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (widget.isShowBottomNav)
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 200),
                                bottom: value ? 0 : -65,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Container(
                                    width: AppSize.getAppWidth(context),
                                    color: Palette.blackPurple,
                                    height: 65,
                                    child: Row(
                                      children: [
                                        TabIcon(
                                          isActive: selectValue == 0,
                                          onPress: () {
                                            widget.onSelect!(0);
                                            _selectedIndex.value = 0;
                                          },
                                          selectedIconPath: AssetPath.getIcon(
                                              'class_filled.svg'),
                                          unselectedIconPath: AssetPath.getIcon(
                                              'class_outlined.svg'),
                                        ),
                                        TabIcon(
                                          isActive: selectValue == 1,
                                          onPress: () {
                                            widget.onSelect!(1);
                                            _selectedIndex.value = 1;
                                          },
                                          selectedIconPath: AssetPath.getIcon(
                                              'assistance_filled.svg'),
                                          unselectedIconPath: AssetPath.getIcon(
                                              'assistance_outlined.svg'),
                                        ),
                                        TabIcon(
                                          isActive: selectValue == 2,
                                          onPress: () {
                                            widget.onSelect!(2);
                                            _selectedIndex.value = 2;
                                          },
                                          selectedIconPath: AssetPath.getIcon(
                                              'leaderboard_filled.svg'),
                                          unselectedIconPath: AssetPath.getIcon(
                                              'leaderboard_outlined.svg'),
                                        ),
                                        TabIcon(
                                          isActive: selectValue == 3,
                                          onPress: () {
                                            widget.onSelect!(3);
                                            _selectedIndex.value = 3;
                                          },
                                          selectedIconPath: AssetPath.getIcon(
                                              'extras_filled.svg'),
                                          unselectedIconPath: AssetPath.getIcon(
                                              'extras_outlined.svg'),
                                        ),
                                        TabIcon(
                                          isActive: selectValue == 4,
                                          onPress: () {
                                            widget.onSelect!(4);
                                            _selectedIndex.value = 4;
                                          },
                                          selectedIconPath: AssetPath.getIcon(
                                              'people_filled.svg'),
                                          unselectedIconPath: AssetPath.getIcon(
                                              'people_outlined.svg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        });
  }
}

class CourseCard extends StatelessWidget {
  final String badge;
  final String title;
  final String time;
  final Color colorBg;
  const CourseCard({
    Key? key,
    required this.badge,
    required this.title,
    required this.time,
    required this.colorBg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          showMainMenuPage(context: context);
        },
        child: Stack(
          children: [
            Container(
              width: AppSize.getAppWidth(context),
              height: 180,
              color: colorBg,
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                height: 180,
                width: 200,
                child: SvgPicture.asset(
                  AssetPath.getVector(
                    'bg_attribute2.svg',
                  ),
                  fit: BoxFit.cover,
                  color: Palette.black.withOpacity(.1),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                height: 180,
                width: 180,
                child: SvgPicture.asset(
                  AssetPath.getVector(
                    'bg_attribute2.svg',
                  ),
                  fit: BoxFit.cover,
                  color: Palette.black.withOpacity(.1),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            title,
                            style: kTextTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Palette.white,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 43,
                          height: 47,
                          child: SvgPicture.asset(
                            badge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      time,
                      style: kTextTheme.bodyMedium?.copyWith(
                        color: Palette.white,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        4,
                        (index) => Transform.translate(
                          offset: Offset((-18 * index).toDouble(), 0),
                          child: Builder(builder: (context) {
                            if (index == 3) {
                              return Container(
                                width: 25,
                                height: 25,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette.grey,
                                ),
                                child: Center(
                                  child: Text(
                                    '+10',
                                    style: kTextTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Palette.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Palette.grey),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    AssetPath.getImage(
                                        'avatar${index + 1}.jpg'),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
