import 'dart:async';
import 'package:mood_track/configs/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mood_track/data/db/hive.dart';

class LoginServices {
  void checkStatusAndLogin(context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final hiveService = HiveService();

    if (user != null) {
      Timer(const Duration(seconds: 5), () {
        hiveService.addInitialEmojiList();
        // Check if the user is still logged in after the timer expires
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, RouteName.bottomNavRoute);
      });
    }
  }
}
