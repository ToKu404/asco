import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/app_route.dart';
import 'package:asco/src/domain/entities/auth_entities/user_credential_entity.dart';
import 'package:asco/src/presentations/features/admin/admin_home_page.dart';
import 'package:asco/src/presentations/features/home/home_page.dart';
import 'package:asco/src/presentations/features/login/welcome_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/widgets/asco_loading.dart';

void showWrapper({required BuildContext context}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const Wrapper(),
      settings: const RouteSettings(name: AppRoute.wrapper),
    ),
    (route) => false,
  );
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

    if (userNotifier.isInitState('single') ||
        userNotifier.isErrorState('single')) {
      return const WelcomePage();
    }

    if (userNotifier.isLoadingState('single')) {
      return const AscoLoading(withScaffold: true);
    }

    if (userNotifier.isSuccessState('single')) {
      final UserCredentialEntity? user = userNotifier.data;

      if (user == null) return const WelcomePage();

      if (user.roleId == 0) return const AdminHomePage();

      return HomePage(roleId: user.roleId);
    }

    return const WelcomePage();
  }
}
