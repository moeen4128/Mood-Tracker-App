import 'package:mood_track/data/db/boxes.dart';
import 'package:mood_track/model/mood_emoji.dart';
import 'package:mood_track/utils/app_constants.dart';
import 'package:mood_track/utils/utils.dart';

class HiveService {
  Future<void> addInitialEmojiList() async {
    if (boxMood.isEmpty) {
      await boxMood.addAll(AppConstants.listEmoji);
    }
  }

  Future<List<MoodEmoji>> getEmojiList() async {
    final listEmoji = boxMood.values.toList();
    return listEmoji.cast<MoodEmoji>();
  }

  Future<void> addEmoji(String key, MoodEmoji value) async {
    if (!boxMood.containsKey(key)) {
      await boxMood.put(key, value);
    } else {
      Utils.toastMessage('Already added');
    }
  }
}
