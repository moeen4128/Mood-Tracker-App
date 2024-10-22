import 'package:intl/intl.dart';
import 'package:mood_track/data/db/hive.dart';
import 'package:mood_track/data/firebase_services/firebase_database.dart';
import 'package:mood_track/model/activity.dart';
import 'package:mood_track/model/mood_emoji.dart';
import 'package:mood_track/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mood_track/utils/utils.dart';

class HomeProvider with ChangeNotifier {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  final String _currentDay =
      DateFormat('dd MMM, yyyy - hh:mm a').format(DateTime.now());
  String get currentDay => _currentDay;

  String _selectedMood = 'Happy';
  String get selectedMood => _selectedMood;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<MoodEmoji> _listEmoji = [];
  List<MoodEmoji> get listEmoji => _listEmoji;

  List<Activity> _activityList = [];
  List<Activity> get activityList => _activityList;

  bool _isActivityLoading = true;
  bool get isActivityLoading => _isActivityLoading;

  bool _isUserLoading = true;
  bool get isUserLoading => _isUserLoading;

  final feelingController = TextEditingController();
  final feelingEmojiController = TextEditingController();
  final reasonController = TextEditingController();

  final hiveService = HiveService();
  final _dbService = DataServices();

  Future<void> setSelectedMood(String newVal, int newIndex) async {
    _selectedMood = newVal;
    _selectedIndex = newIndex;
    notifyListeners();
  }

  Future<void> addUserCurrentMood() async {
    if (reasonController.text.isEmpty) {
      Utils.toastMessage('Reason Can\'t be empty');
      return;
    }

    final dateTime = DateTime.now()
        .toIso8601String()
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');

    final data = {
      'moodNo': _selectedIndex,
      'feelingName': _selectedMood,
      'feelingEmoji': _listEmoji[_selectedIndex].moodEmoji,
      'reason': reasonController.text,
      'date': DateFormat('dd MMM, yyyy - hh:mm a').format(DateTime.now()),
    };
    await _dbService.addUserCurrentFeeling(
      data: data,
      userId: _dbService.currentUser!.uid,
      dateTime: dateTime,
      onError: (error) => Utils.toastMessage(error),
      onSuccess: () {
        return updateUser();
      },
    );
  }

  Future<void> setEmojiList() async {
    _listEmoji = await hiveService.getEmojiList();
    notifyListeners();
  }

  Future<void> updateUser() async {
    final data = {
      'userFeeling': _selectedMood,
      'feelingEmoji': _listEmoji[_selectedIndex].moodEmoji,
    };
    await _dbService.updateUser(
      _dbService.currentUser!.uid,
      data,
      () async {
        await getUserData();
        await getActivityData();
      },
      (error) => null,
    );
  }

  Future<void> getUserData() async {
    try {
      _isUserLoading = true;
      final user = await _dbService.getCurrentUserData();
      if (user != null) {
        _userModel = user;
        _isUserLoading = false;
        await getActivityData();
        notifyListeners();
      }
    } catch (error) {
      print(error);
    } finally {
      _isUserLoading = false;
    }
  }

  Future<void> getActivityData() async {
    try {
      _isActivityLoading = true;

      final activity =
          await _dbService.getActivitiesByMood(_userModel!.userFeeling);
      _activityList = activity;
      _isActivityLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching activity data: $error');
      throw Exception(
          error); // Rethrow the error for higher-level error handling
    } finally {
      _isActivityLoading = false;
    }
  }

  Future<void> addEmoji() async {
    await hiveService
        .addEmoji(
            'key_${feelingController.text.trim()}',
            MoodEmoji(
                moodEmoji: feelingEmojiController.text.trim(),
                moodTitle: feelingController.text.trim()))
        .then((value) => resetControllers());

    await setEmojiList();
  }

  void resetControllers() {
    feelingController.clear();
    feelingEmojiController.clear();
  }

  void resetReasonController() {
    reasonController.clear();
    _selectedMood = 'Happy';
    _selectedIndex = 0;
  }
}
