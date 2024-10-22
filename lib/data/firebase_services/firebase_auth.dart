import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  UserCredential? result;

  Future<UserCredential?> signUpWithEmailAndPassword({
    required Function(String error) onError,
    required Function() onSuccess,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user != null) {
        onSuccess();
      }
      return user;
    } on FirebaseAuthException catch (error) {
      handleAuthError(error, onError);
      return null;
    }
  }

  Future<User?> signInWithMail({
    required String email,
    required String password,
    required Function(String error) onError,
    required Function() onSuccess,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        onSuccess();
      }
      return result.user;
    } on FirebaseAuthException catch (error) {
      handleAuthError(error, onError);
      return null;
    }
  }

  void handleAuthError(
      FirebaseAuthException error, Function(String error) onError) {
    String errorMessage;
    print("Error code: ${error.code}");
    switch (error.code) {
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "network-request-failed":
        errorMessage = "Your network is not stable";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case "invalid-credential": // Handle invalid credential error
        errorMessage =
            "Invalid email or password."; // Provide a specific error message for this case
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    onError(errorMessage);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
