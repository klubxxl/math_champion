import 'package:shared_preferences/shared_preferences.dart';

class RecordHelper {
  static Future<int> fetchAndGetRecord(int score, bool isHard) async {
    final prefs = await SharedPreferences.getInstance();
    String key = isHard ? 'hardRecord' : 'easyRecord';
    int? actualRecord = prefs.containsKey(key) ? prefs.getInt(key) : 0;
    if ((actualRecord ?? 0) >= score) {
      return actualRecord ?? 0;
    } else {
      prefs.setInt(key, score);
      return score;
    }
  }
}
