import 'dart:ui';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/src/presentations/features/login/widgets/login_modal.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void showWelcomePage({required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
        settings: const RouteSettings(
          name: AppRoute.welcomePage,
        ),
      ),
      (route) => false);
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.grey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
              child: RiveAnimation.asset(
            AssetPath.getRive('anim_bg.riv'),
            fit: BoxFit.cover,
          )),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const AppBarTitle(),
                  const Spacer(),
                  SizedBox(
                    width: 240,
                    child: Column(children: [
                      const SizedBox(
                        height: 16,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Sistem Kelola',
                            style: kTextTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.05,
                              color: Palette.black,
                            ),
                            children: [
                              TextSpan(
                                text: '\nPraktikum & Asistensi',
                                style: kTextTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.05,
                                  color: Palette.purple60,
                                ),
                              )
                            ]),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Membantu pengelolaan data praktikum dan asistensi laboratorium sistem informasi Universitas Hasanuddin.",
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Palette.white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 6,
                              color: const Color.fromARGB(255, 75, 63, 189)
                                  .withOpacity(.2))
                        ]),
                    child: MaterialButton(
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          transitionDuration: const Duration(
                            milliseconds: 400,
                          ),
                          transitionBuilder:
                              (context, animation, secondaryAnimation, child) {
                            Tween<Offset> tween;
                            tween = Tween(
                                begin: const Offset(0, -1), end: Offset.zero);
                            return SlideTransition(
                              position: tween.animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              child: child,
                            );
                          },
                          barrierLabel: 'Masuk',
                          pageBuilder: (context, _, __) {
                            return const LoginModal();
                          },
                          
                        );
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Lanjutkan',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Aplikasi ini khusus asisten dan praktikan. Tekan lanjutkan untuk mulai menggunakan.",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
