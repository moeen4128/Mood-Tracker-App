class MoodHistory {
  final String date;
  final String feelingEmoji;
  final String feelingName;
  final int moodNo;
  final String reason;

  MoodHistory(
      {required this.date,
      required this.feelingEmoji,
      required this.feelingName,
      required this.moodNo,
      required this.reason});

  factory MoodHistory.fromJson(Map<String, dynamic> json) {
    return MoodHistory(
      date: json['date'] ?? '',
      feelingEmoji: json['feelingEmoji'] ?? '',
      feelingName: json['feelingName'] ?? '',
      moodNo: json['moodNo'] ?? '',
      reason: json['reason'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'feelingEmoji': feelingEmoji,
      'feelingName': feelingName,
      'moodNo': moodNo,
      'reason': reason,
    };
  }
}
