import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mood_track/data/firebase_services/firebase_database.dart';
import 'package:mood_track/model/mood_history.dart';

class ReportProvider extends ChangeNotifier {
  List<MoodHistory> _moodHistoryList = [];
  List<MoodHistory> get moodHistoryList => _moodHistoryList;

  List<MoodHistory> _weeklyMoodList = [];
  List<MoodHistory> get weeklyMoodList => _weeklyMoodList;

  List<MoodHistory> _monthlyMoodList = [];
  List<MoodHistory> get monthlyMoodList => _monthlyMoodList;

  bool _isWeeklyListLoading = true;
  bool get isHistoryLoading => _isWeeklyListLoading;

  final _dbService = DataServices();

  String _weeklyAverage = '';
  String get weeklyAverage => _weeklyAverage;

  String _monthlyAverage = '';
  String get monthlyAverage => _monthlyAverage;

  Future<void> getWeeklyMoodHistory(DateTime startDate) async {
    final endDate = startDate.add(const Duration(days: 7));
    final weeklyMoodHistory = _moodHistoryList.where((mood) {
      final date = DateFormat('dd MMM, yyyy - hh:mm a').parse(mood.date, true);
      return date.isAfter(startDate) && date.isBefore(endDate);
    }).toList();
    _weeklyMoodList = weeklyMoodHistory;
    await calculateWeeklyAverage(); // Calculate weekly average mood
  }

  Future<void> getMonthlyMoodHistory(DateTime startDate) async {
    final endDate =
        DateTime(startDate.year, startDate.month + 1, 0, 23, 59, 59);
    final monthlyMoodHistory = _moodHistoryList.where((mood) {
      final date = DateFormat('dd MMM, yyyy - hh:mm a').parse(mood.date, true);
      return date.isAfter(startDate) && date.isBefore(endDate);
    }).toList();
    _monthlyMoodList = monthlyMoodHistory;
    await calculateMonthlyAverage(); // Calculate monthly average mood
  }

  Future<void> getMoodHistory() async {
    try {
      _isWeeklyListLoading = true;
      _moodHistoryList = await _dbService.getUserMoodHistory();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching mood history: $error');
      }
      throw Exception(error);
    } finally {
      _isWeeklyListLoading = false;
      notifyListeners();
    }
  }

  Future<void> calculateWeeklyAverage() async {
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, today.day, 0, 0, 0);
    final endDate = startDate.add(const Duration(days: 7));
    _weeklyAverage = _calculateAverageMood(startDate, endDate);
    notifyListeners();
  }

  Future<void> calculateMonthlyAverage() async {
    final today = DateTime.now();
    final startDate = DateTime(today.year, today.month, 1, 0, 0, 0);
    final daysOfMonth = daysInMonth(today.year, today.month);
    final endDate = startDate.add(Duration(days: daysOfMonth, hours: 23));
    _monthlyAverage = _calculateAverageMood(startDate, endDate);
    notifyListeners();
  }

  String _calculateAverageMood(DateTime startDate, DateTime endDate) {
    final filteredMoods = _moodHistoryList.where((mood) {
      final date = DateFormat('dd MMM, yyyy - hh:mm a').parse(mood.date, true);
      return date.isAfter(startDate) && date.isBefore(endDate) ||
          date.isAtSameMomentAs(startDate) ||
          date.isAtSameMomentAs(endDate);
    }).toList();

    if (filteredMoods.isEmpty) {
      return ''; // Handle no mood entries in the period
    }

    Map<int, int> moodCounts = {};
    int maxCount = 0;
    int mostRepeatedMoodNo = 0;

    // Count occurrences of each moodNo
    for (var mood in filteredMoods) {
      moodCounts[mood.moodNo] ??= 0;
      moodCounts[mood.moodNo] =
          moodCounts[mood.moodNo]! + 1; // Increment the count
    }

    // Find moodNo with the highest count
    moodCounts.forEach((moodNo, count) {
      if (count > maxCount) {
        maxCount = count;
        mostRepeatedMoodNo = moodNo;
      }
    });

    final moodName = _moodHistoryList
        .firstWhere((element) => element.moodNo == mostRepeatedMoodNo)
        .feelingName;

    final moodEmoji = _moodHistoryList
        .firstWhere((element) => element.moodNo == mostRepeatedMoodNo)
        .feelingEmoji;

    return '$moodEmoji\n$moodName';
  }

  int daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
