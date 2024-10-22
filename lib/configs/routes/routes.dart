import 'package:mood_track/views/login/login_view.dart';
import 'package:mood_track/views/mood%20entry/mood_entry_view.dart';
import 'package:mood_track/views/signup/signup_view.dart';
import 'package:mood_track/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mood_track/configs/routes/routes_name.dart';
import 'package:mood_track/views/bottom_nav_home/bottom_nav_home.dart';
import 'package:mood_track/views/home/home_view.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RouteName.bottomNavRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavHome());

      case RouteName.homeRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());
      case RouteName.loginRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());

      case RouteName.signupRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RouteName.moodEntryRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) => const MoodEntryView());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
