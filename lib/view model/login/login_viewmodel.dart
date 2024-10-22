import 'package:mood_track/data/firebase_services/firebase_auth.dart';
import 'package:mood_track/data/firebase_services/firebase_database.dart';
import 'package:mood_track/utils/utils.dart';
import 'package:mood_track/view%20model/services/login_services.dart';
import 'package:flutter/material.dart';

class LoginViewProvider with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  final realtimeDatabase = DataServices();

  bool isFormValid(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Utils.flushBarErrorMessage('Fields Can\'t be empty', context);
      return false;
    } else {
      return true;
    }
  }

  Future signInUser(BuildContext context) async {
    try {
      await authService.signInWithMail(
        onError: (error) {
          Navigator.pop(context);
          Utils.flushBarErrorMessage(error, context);
        },
        onSuccess: () {
          LoginServices().checkStatusAndLogin(context);
        },
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}
