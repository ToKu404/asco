import 'dart:ui';

import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/constants/asset_path.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/utils/rive_utils.dart';
import 'package:asco/src/presentations/features/home/home_page.dart';
import 'package:asco/src/presentations/widgets/app_bar_title.dart';
import 'package:asco/src/presentations/widgets/blur_background.dart';
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
                            style: kTextTheme.headline1?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.05,
                              color: Palette.black,
                            ),
                            children: [
                              TextSpan(
                                text: '\nPraktikum & Asistensi',
                                style: kTextTheme.headline1?.copyWith(
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
                            return BlurBackgroundContainer(
                              modal: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 32,
                                    horizontal: 24,
                                  ),
                                  height: 520,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Palette.white.withOpacity(.94),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  child: Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    backgroundColor: Colors.transparent,
                                    body: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Masuk',
                                              style: kTextTheme.headline2
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              child: Text(
                                                'Untuk mendapatkan informasi akun anda sialhkan hubungi kordinator lab.',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const _SignInForm(),
                                          ],
                                        ),
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: -48,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const CircleAvatar(
                                              radius: 16,
                                              backgroundColor: Palette.white,
                                              child: Icon(
                                                Icons.close,
                                                color: Palette.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
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

class _SignInForm extends StatefulWidget {
  const _SignInForm();

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isShowLoading = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  void signIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formKey.currentState!.validate()) {
        check.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });

          Future.delayed(const Duration(seconds: 1), () {
            showHomePage(context: context);
          });
        });
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Username",
                style: TextStyle(
                  color: Palette.purple80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onSaved: (email) {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.greyDark),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Palette.purple80,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.purple60,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_rounded,
                              size: 18,
                              color: Palette.white,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              const Text(
                "Password",
                style: TextStyle(
                  color: Palette.purple80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onSaved: (password) {},
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.greyDark),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Palette.purple80,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.purple60,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.lock,
                            size: 18,
                            color: Palette.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  signIn(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.purple60,
                  minimumSize: const Size(double.infinity, 56),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Palette.purple80,
                  size: 18,
                ),
                label: const Text(
                  'Sign In',
                  style: TextStyle(color: Palette.white),
                ),
              )
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  AssetPath.getRive('checkerror.riv'),
                  onInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard);
                    check = controller.findSMI("Check") as SMITrigger;
                    error = controller.findSMI("Error") as SMITrigger;
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});

  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            width: size,
            height: size,
            child: child,
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
