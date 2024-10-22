import 'package:mood_track/data/firebase_services/firebase_auth.dart';
import 'package:mood_track/data/firebase_services/firebase_database.dart';
import 'package:mood_track/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  final realtimeDatabase = DataServices();

  bool isFormValid(BuildContext context) {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        ageController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Utils.flushBarErrorMessage('Fields Can\'t be empty', context);

      return false;
    } else if (usernameController.text.length < 3) {
      Utils.flushBarErrorMessage(
          'Username must be at least 3 character', context);
      return false;
    } else if (passwordController.text.length < 6) {
      Utils.flushBarErrorMessage('Password can\'t be less than 6', context);
      return false;
    } else {
      return true;
    }
  }

  Future<User?> signUpUser(BuildContext context) async {
    try {
      final user = await authService.signUpWithEmailAndPassword(
        onError: (error) {
          Navigator.pop(context);

          Utils.flushBarErrorMessage(error, context);
        },
        onSuccess: () async {
          Navigator.pop(context);
          Utils.showCustomSnackbar(
              context, 'Account Creation', 'Account Created Successfully');
          Navigator.pop(context);
        },
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      return user?.user;
    } catch (e) {
      throw Exception(e);
    }
  }

  addToDatabase(String? uid) async {
    if (uid == null) return;
    Map<String, dynamic> data = {
      'name': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'age': ageController.text.trim(),
      'userFeeling': 'Normal',
      'feelingEmoji': '🙂',
    };
    await realtimeDatabase.createUser(
      data: data,
      userId: uid,
      onError: (error) => Utils.toastMessage(error),
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.clear();
    ageController.clear();
    passwordController.clear();
    emailController.clear();
  }
}
