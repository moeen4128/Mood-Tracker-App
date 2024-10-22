import 'package:mood_track/view%20model/services/splash_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mood_track/configs/assets/image_assets.dart';
import 'package:mood_track/configs/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> animate = ValueNotifier<bool>(false);
  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    startAnimation();
    splashService.isLogin(context);
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacementNamed(context, RouteName.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ClipOval(
        child: Image.asset(
          ImageAssets.appLogo,
          height: 250,
        ),
      )),
    );
  }
}
