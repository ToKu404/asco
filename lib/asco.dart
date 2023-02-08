import 'package:asco/core/constants/color_const.dart';
import 'package:asco/src/presentations/features/initial/splash_page.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asco/injection.dart' as di;

import 'package:provider/provider.dart';

class AscoApp extends StatelessWidget {
  const AscoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Palette.blackPurple,
        statusBarColor: Palette.blackPurple,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Asco',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
