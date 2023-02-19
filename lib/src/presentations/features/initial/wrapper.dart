import 'package:asco/core/constants/app_route.dart';
import 'package:asco/core/state/request_state.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential.dart';
import 'package:asco/src/presentations/features/admin/admin_home_page.dart';
import 'package:asco/src/presentations/features/home/home_page.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showWrapper({required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Wrapper(),
        settings: const RouteSettings(
          name: AppRoute.wrapper,
        ),
      ),
      (route) => false);
}

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<AuthNotifier>(context, listen: false).getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Wrapper to check if user is login or not
    final userNotifier = context.watch<AuthNotifier>();
    if (userNotifier.isLoadingState('single') ||
        userNotifier.isInitState('single')) {
      return const AscoLoading(
        withScaffold: true,
      );
    } else if (userNotifier.isSuccessState('single')) {
      final UserCredentialEntity? user = userNotifier.data;
      if (user == null) {
        return const WelcomePage();
      } else {
        if (user.roleId == 0) {
          return const AdminHomePage();
        } else if (user.roleId == 1) {
          return HomePage(
            roleId: user.roleId,
          );
        } else if (user.roleId == 2) {
          return HomePage(
            roleId: user.roleId,
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    } else {
      return const AscoLoading(
        withScaffold: true,
      );
    }
  }
}
