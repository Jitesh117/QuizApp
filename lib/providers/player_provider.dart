import 'package:flutter/material.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerProvider with ChangeNotifier {
  int highScore = 0;
  String name = "Guest";
  int level = 0;
  int maxStreak = 0;
  int questionsPlayed = 0;
  int points = 0;
  String avatarPath = "assets/userAvatars/memojis/user_profile_0.png";

  // variables for storing badges information
  List<List<String>> badgesEarned = List.generate(
      categoryNames.length, (index) => List.generate(3, (index) => "0"));

  void changeAvatar(String imagePath) async {
    avatarPath = imagePath;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('avatarPath', avatarPath);
    notifyListeners();
  }

  void fetchPlayerData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    maxStreak = pref.getInt('highestStreak') ?? 0;
    questionsPlayed = pref.getInt('questionsPlayed') ?? 0;
    points = pref.getInt('points') ?? 0;
    avatarPath = pref.getString('avatarPath') ??
        "assets/userAvatars/memojis/user_profile_0.png";

    // badges information
    for (int i = 0; i < categoryNames.length; i++) {
      badgesEarned[i] =
          pref.getStringList("category$i") ?? List.generate(3, (index) => '0');
    }
  }

  void updateMaxStreak(int streak) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (streak > maxStreak) {
      maxStreak = streak;
      pref.setInt('highestStreak', maxStreak);
    }
    questionsPlayed++;
    pref.setInt('questionsPlayed', questionsPlayed);
    notifyListeners();
  }

  void updatePoints(bool isCorrect) async {
    if (isCorrect) {
      points += 5;
    } else {
      points -= 2;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('points', points);

    notifyListeners();
  }
}
