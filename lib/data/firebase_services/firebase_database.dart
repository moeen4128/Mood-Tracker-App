import 'dart:async';
import 'package:mood_track/model/activity.dart';
import 'package:mood_track/model/mood_history.dart';
import 'package:mood_track/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DataServices {
  User? currentUser;
  final _authService = FirebaseAuth.instance;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  DataServices() {
    currentUser = _authService.currentUser;
  }

  Future<void> createUser({
    required Map<String, dynamic> data,
    required String userId,
    required Function(String error) onError,
  }) async {
    try {
      await _dbRef
          .child('Users')
          .child(userId)
          .set(data)
          .onError((error, stackTrace) => onError(error.toString()));
    } catch (error) {
      onError(error.toString());
    }
  }

  Future<void> addUserCurrentFeeling({
    required Map<String, dynamic> data,
    required String userId,
    required String dateTime,
    required Function(String error) onError,
    required Function() onSuccess,
  }) async {
    try {
      await _dbRef
          .child('Users')
          .child(currentUser!.uid)
          .child('user_moods')
          .push()
          .set(data)
          .onError((error, stackTrace) => onError(error.toString()));

      onSuccess();
    } catch (error) {
      onError(error.toString());
    }
  }

  Future<void> updateUser(
    String uid,
    Map<String, String> data,
    Function() onSuccess,
    Function(String error) errorCallback,
  ) async {
    try {
      final dbRef = _dbRef.child("Users").child(uid);
      dbRef
          .update(data)
          .onError((error, stackTrace) => errorCallback(error.toString()));

      onSuccess();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Activity>> getActivitiesByMood(String mood) async {
    final activitiesRef = FirebaseDatabase.instance.ref().child('activities');
    final event = await activitiesRef.child(mood.toLowerCase()).once();
    List<Activity> activities = [];
    if (event.snapshot.value != null) {
      final datasnapshot = event.snapshot;
      for (var element in datasnapshot.children) {
        final activity = Activity.fromJson(
            Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>));
        activities.add(activity);
      }
    }
    return activities;
  }

  Future<List<MoodHistory>> getUserMoodHistory() async {
    final userMoodRef = FirebaseDatabase.instance.ref().child('Users');
    final event =
        await userMoodRef.child(currentUser!.uid).child('user_moods').once();

    List<MoodHistory> moodsList = [];
    if (event.snapshot.value != null) {
      final datasnapshot = event.snapshot;
      for (var element in datasnapshot.children) {
        final moods = MoodHistory.fromJson(
            Map<String, dynamic>.from(element.value as Map<dynamic, dynamic>));
        moodsList.add(moods);
      }
    }
    return moodsList;
  }

// Method to fetch user data from the Realtime Database
  Future<UserModel?> getCurrentUserData() async {
    try {
      // Get the current user's UID
      final String uid = _authService.currentUser?.uid ?? '';

      // Fetch the user data from the Realtime Database
      final event = await _dbRef.child("Users").child(uid).once();

      // Check if data exists
      if (event.snapshot.value != null) {
        // Parse the fetched data into a User object
        UserModel user = UserModel.fromMap(Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>));
        return user;
      } else {
        return null; // User data not found
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<void> addActivitiesToFirebase() async {
  //   DatabaseReference activitiesRef =
  //       FirebaseDatabase.instance.ref().child('activities');

  //   // Iterate through the moodActivities list
  //   for (int i = 0; i < AppConstants.moodActivities.length; i++) {
  //     List<Activity> activities = AppConstants.moodActivities[i];
  //     String mood =
  //         _getMoodName(i); // Function to get the mood name based on index

  //     // Iterate through the activities for the current mood
  //     for (int j = 0; j < activities.length; j++) {
  //       Activity activity = activities[j];
  //       // Generate a unique key for each activity
  //       String? key = activitiesRef.child(mood).push().key;

  //       // Set the activity data in Firebase under the corresponding mood node
  //       await activitiesRef.child(mood).child(key ?? '').set(activity.toJson());
  //     }
  //   }

  //   print('Activities added to Firebase successfully.');
  // }

  // String _getMoodName(int index) {
  //   switch (index) {
  //     case 0:
  //       return 'happy';
  //     case 1:
  //       return 'sad';
  //     case 2:
  //       return 'funny';
  //     case 3:
  //       return 'shameful';
  //     case 4:
  //       return 'tired';
  //     case 5:
  //       return 'angry';
  //     case 6:
  //       return 'proud';
  //     default:
  //       return '';
  //   }
  // }
}
