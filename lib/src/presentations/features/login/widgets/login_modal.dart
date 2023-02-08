import 'package:asco/core/constants/color_const.dart';
import 'package:asco/core/constants/text_const.dart';
import 'package:asco/core/services/auth_service.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/presentations/features/admin/admin_home_page.dart';
import 'package:asco/src/presentations/features/home/home_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:asco/src/presentations/widgets/blur_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LoginModal extends StatelessWidget {
  const LoginModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlurBackgroundContainer(
      modal: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 24,
          ),
          height: 520,
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      style: kTextTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Untuk mendapatkan informasi akun anda silahkan hubungi kordinator lab.',
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
                      context.read<AuthNotifier>().reset();
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
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm();

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier<bool> isHide = ValueNotifier(true);

  bool isLoadingStart = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    isHide.dispose();
    super.dispose();
  }

  void signIn(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final provider = context.read<AuthNotifier>();
      final username = _usernameController.text.trim();
      final password =
          AuthService.hashPassword(_passwordController.text.trim());
      provider.login(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthNotifier>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (provider.loginState == RequestState.error) {
        Future.delayed(const Duration(seconds: 2), () {
          if (isLoadingStart) Navigator.pop(context);
          isLoadingStart = false;
        });
      } else if (provider.loginState == RequestState.loading) {
        isLoadingStart = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const AscoLoading();
          },
        );
      } else if (provider.loginState == RequestState.success) {
        Future.delayed(const Duration(seconds: 2), () {
          if (isLoadingStart) Navigator.pop(context);
          isLoadingStart = false;

          if (provider.userCredentialEntity != null) {
            final credentialData = provider.userCredentialEntity!;
            if (credentialData.roleId == 0) {
              showAdminHomePage(context: context);
            } else if (credentialData.roleId == 1) {
              showHomePage(context: context);
            } else if (credentialData.roleId == 2) {
              showHomePage(context: context);
            }
          }
          provider.reset();
        });
      }
    });

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
                  controller: _usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harap isi username terlebih dahulu";
                    }
                    return null;
                  },
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
                    errorStyle: const TextStyle(height: 1),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.plum60),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Palette.plum60),
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
                child: ValueListenableBuilder<bool>(
                    valueListenable: isHide,
                    builder: (context, data, _) {
                      return TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Harap isi password terlebih dahulu";
                          }
                          return null;
                        },
                        obscureText: data,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Palette.greyDark),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Palette.purple80,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              isHide.value = !data;
                            },
                            icon: Icon(
                              isHide.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Palette.purple80,
                            ),
                          ),
                          errorStyle: const TextStyle(height: 1),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Palette.plum60),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Palette.plum60),
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
                      );
                    }),
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
      ],
    );
  }
}
