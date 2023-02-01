import 'dart:math';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/size_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:asco/src/presentations/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showHomePage({required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
        settings: const RouteSettings(
          name: AppRoute.homePage,
        ),
      ),
      (route) => false);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> isSideMenuClosed = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    isSideMenuClosed.dispose();
  }

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> radiusAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
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
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      width: AppSize.getAppWidth(context) * .7,
                      left: value ? -AppSize.getAppWidth(context) * .7 : 0,
                      height: MediaQuery.of(context).size.height,
                      child: const SideMenu(),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(
                          3,
                          2,
                          0.001,
                        )
                        ..rotateY(
                            animation.value - 30 * animation.value * pi / 180),
                      child: Transform.translate(
                        offset: Offset(
                            animation.value *
                                (AppSize.getAppWidth(context) * .7 - 15),
                            0),
                        child: Transform.scale(
                          scale: scaleAnimation.value,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(radiusAnimation.value),
                            child: const _BuildBody(),
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: value ? 0 : AppSize.getAppWidth(context) * .7 - 40,
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
                                  ? AssetPath.getIcons('hamburger.svg')
                                  : AssetPath.getIcons('close.svg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      appBar: AppBar(
        title: const AppBarTitle(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            children: [
              CourseCard(
                badge: AssetPath.getVector('badge_android.svg'),
                colorBg: Palette.purple60,
                time: 'Setiap hari Senin Pukul 10.10 - 12.40',
                title: 'Pemrograman Mobile A',
              ),
              const SizedBox(
                height: 12,
              ),
              CourseCard(
                badge: AssetPath.getVector('badge_oop.svg'),
                colorBg: Palette.azure40,
                time: 'Setiap hari Senin Pukul 10.10 - 12.40',
                title: 'Pemrograman Berbasis Objek B',
              ),
            ],
          ),
        ),
      ),
    );
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
                          style: kTextTheme.headline5?.copyWith(
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
                    style: kTextTheme.bodyText1?.copyWith(
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
                                  style: kTextTheme.bodyText2?.copyWith(
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
                              border: Border.all(width: 1, color: Palette.grey),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  AssetPath.getImage('avatar${index + 1}.jpg'),
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
    );
  }
}
