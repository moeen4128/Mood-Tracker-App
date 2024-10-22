import 'dart:async';

import 'package:mood_track/configs/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 5), () {
        // Check if the user is still logged in after the timer expires

        if (auth.currentUser != null) {
          Navigator.pushReplacementNamed(context, RouteName.bottomNavRoute);
        }
      });
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, RouteName.loginRoute));
    }
  }
}
