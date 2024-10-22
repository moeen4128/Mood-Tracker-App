import 'package:hive_flutter/adapters.dart';
part 'mood_emoji.g.dart';

@HiveType(typeId: 0)
class MoodEmoji {
  @HiveField(0)
  final String moodTitle;
  @HiveField(1)
  final String moodEmoji;

  MoodEmoji({
    required this.moodEmoji,
    required this.moodTitle,
  });
}
