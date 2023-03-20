import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:asco/core/constants/app_info.dart';
import 'package:asco/core/constants/color_const.dart';
import 'package:asco/injection.dart' as di;
import 'package:asco/src/presentations/features/initial/splash_page.dart';
import 'package:asco/src/presentations/providers/assistance_notifier.dart';
import 'package:asco/src/presentations/providers/auth_notifier.dart';
import 'package:asco/src/presentations/providers/classroom_notifier.dart';
import 'package:asco/src/presentations/providers/meeting_notifier.dart';
import 'package:asco/src/presentations/providers/practicum_notifier.dart';
import 'package:asco/src/presentations/providers/profile_notifier.dart';

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
        ChangeNotifierProvider(
          create: (_) => di.locator<ProfileNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PracticumNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ClassroomNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MeetingNotifier>(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<AttendanceNotifier>(),
        // ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AssistanceNotifier>(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<UserPracticumNotifier>(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppInfo.appName,
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
