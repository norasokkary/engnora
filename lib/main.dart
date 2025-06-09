import 'package:flutter/material.dart';
import 'package:predicts_diabetes/JSON/users.dart';
import 'package:predicts_diabetes/splash_screen.dart';
import 'package:predicts_diabetes/upload_page.dart';
import 'Views/auth.dart';
import 'debug_screen.dart';
import 'doctors_screen.dart';
import 'home_screen.dart';
import 'local_notifications_service.dart';
import 'profile_screen.dart';
import 'recommendation_screen.dart';
import 'reminder_screen.dart';
import 'settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: {
      //   '/': (context) => AuthScreen(),
      //   '/home': (context) => HomeScreen(),
      //   '/reminder': (context) => ReminderScreen(),
      //   '/doctors': (context) => DoctorsScreen(),
      //   '/recommendation': (context) => RecommendationScreen(),
      //   '/profile': (context) => ProfileScreen(),
      //   '/settings': (context) => SettingsScreen(),
      //   '/corneal-exam': (context) => UploadPage(),
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/home':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(builder: (_) => HomeScreen(user: user));
          case '/reminder':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(
                builder: (_) => ReminderScreen(user: user));
          case '/doctors':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(builder: (_) => DoctorsScreen(user: user));
          case '/recommendation':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(
                builder: (_) => RecommendationScreen(user: user));
          case '/profile':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(builder: (_) => ProfileScreen(user: user!));
          case '/settings':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(
                builder: (_) => SettingsScreen(user: user));
          case '/corneal-exam':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(builder: (_) => UploadPage(user: user));
          case '/debug':
            final user = settings.arguments as Users?;
            return MaterialPageRoute(builder: (_) => DebugScreen(user: user));
          default:
            final user = settings.arguments as Users?;
            return MaterialPageRoute(builder: (_) => AuthScreen());
        }
      },
    );
  }
}
