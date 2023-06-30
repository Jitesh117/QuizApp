import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerProvider with ChangeNotifier {
  int highScore = 0;
  String name = "Guest";
  int level = 0;
  int points = 100;
  String avatarPath = "assets/userAvatars/memojis/user_profile_0.png";
  int powerDelete = 2;
  int powerReveal = 2;
  int powerDouble = 2;
  int powerSkip = 2;

  // achievements variables
  List<bool> badge = List.generate(badgeName.length, (index) => false);
  int currentCategory = -1;
  int currentDifficulty = -1;
  int questionsPlayed = 0;
  int maxStreak = 0;
  int currentStreak = 0;
  int threeSecondStreak = 0;
  bool answeredCorrectly = false;
  List<List<bool>> categoryDifficultyPlayed = List.generate(
      badgeName.length, (index) => List.generate(3, (index) => false));
  List<bool> categoryPlayed = List.generate(badgeName.length, (index) => false);

  bool deleteUsed = false;
  bool revealUsed = false;
  bool doubleUsed = false;
  bool skipUsed = false;

  int timeTaken = 0;
  int totalTimeTaken = 0;

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
    points = pref.getInt('points') ?? 100;
    avatarPath = pref.getString('avatarPath') ??
        "assets/userAvatars/memojis/user_profile_0.png";
    if (pref.getInt('powerDelete') == null) {
      pref.setInt('powerDelete', 2);
      pref.setInt('powerReveal', 2);
      pref.setInt('powerDouble', 2);
      pref.setInt('powerSkip', 2);
      pref.setInt('points', 100);
    } else {
      powerDelete = pref.getInt('powerDelete') ?? 2;
      powerReveal = pref.getInt('powerReveal') ?? 2;
      powerDouble = pref.getInt('powerDouble') ?? 2;
      powerSkip = pref.getInt('powerSkip') ?? 2;
    }

    // badges information
    if (pref.getBool('badge0') == null) {
      for (int i = 0; i < badgeName.length; i++) {
        pref.setBool('badge$i', false);
      }
    } else {
      for (int i = 0; i < badgeName.length; i++) {
        badge[i] = pref.getBool('badge$i') ?? false;
      }
    }
    notifyListeners();
  }

  void updateMaxStreak(int streak) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (streak > maxStreak) {
      maxStreak = streak;
      pref.setInt('highestStreak', maxStreak);
    }
    currentStreak = streak;
    questionsPlayed++;
    pref.setInt('questionsPlayed', questionsPlayed);
    notifyListeners();
  }

  void updatePoints(bool isCorrect) async {
    if (isCorrect) {
      if (doubleUsed) {
        points += 10;
      } else {
        points += 5;
      }
    } else {
      points -= 2;
      if (points < 0) points = 0;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('points', points);

    notifyListeners();
  }

  void updatePowerups() async {
    deleteUsed = false;
    revealUsed = false;
    doubleUsed = false;
    skipUsed = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('powerDelete', powerDelete);
    pref.setInt('powerReveal', powerReveal);
    pref.setInt('powerDouble', powerDouble);
    pref.setInt('powerSkip', powerSkip);
    pref.setInt('points', powerSkip);
    notifyListeners();
  }

  Future<bool> buyOrNot(BuildContext context, int price, int powerup) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return points < price
            ? AlertDialog(
                title: const Text(
                  "You have insufficient coins",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      playTapSound();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : AlertDialog(
                title: const Text(
                  "Are you sure you want to buy this?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      playTapSound();
                      Navigator.pop(context, false);
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      playTapSound();
                      points -= price;
                      switch (powerup) {
                        case 0:
                          {
                            powerDelete++;
                          }
                          break;
                        case 1:
                          {
                            powerReveal++;
                          }
                          break;
                        case 2:
                          {
                            powerDouble++;
                          }
                          break;
                        case 3:
                          {
                            powerSkip++;
                          }
                      }
                      updatePowerups();
                      notifyListeners();
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
      },
    );
    return shouldPop!;
  }

  void playTapSound() {
    final player = AudioPlayer();
    player.setVolume(0.5);
    player.play(AssetSource('sounds/ding.mp3'));
  }
// achievement unlock functions

  void badge0to9(int category, int difficulty) {
    if (!badge[category]) {
      if (currentStreak == 10) {
        categoryDifficultyPlayed[category][difficulty] = true;
        bool allCompleted = true;
        for (int i = 0; i < categoryDifficultyPlayed[category].length; i++) {
          allCompleted = allCompleted && categoryDifficultyPlayed[category][i];
        }
        if (allCompleted) {
          badge[category] = true;
        }
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge10() {
    if (!badge[10]) {
      if (timeTaken <= 3 && answeredCorrectly) {
        threeSecondStreak++;
        if (threeSecondStreak == 10) {
          badge[10] = true;
        }
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge11() {
    if (!badge[11] && timeTaken <= 2 && answeredCorrectly) {
      badge[11] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge12() {
    if (!badge[12] && revealUsed && !answeredCorrectly) {
      badge[12] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge13() {
    if (!badge[13] && currentStreak == 25) {
      badge[13] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge14() {
    if (!badge[14]) {
      bool allCompleted = true;
      for (int i = 0; i < genreNames.length; i++) {
        allCompleted = allCompleted && badge[i];
      }
      if (allCompleted) {
        badge[14] = true;
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge15(int category, int difficulty) {
    if (!badge[15]) {
      categoryPlayed[category] = true;
      bool allCompleted = false;
      for (int i = 0; i < genreNames.length; i++) {
        allCompleted = allCompleted && categoryPlayed[i];
      }
      if (allCompleted) {
        badge[15] = true;
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge16() {
    if (!badge[16]) {
      if (currentStreak == 10 && totalTimeTaken <= 10) {
        badge[16] = true;
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge17() {
    if (!badge[17] && doubleUsed && answeredCorrectly) {
      badge[17] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge18() {
    if (!badge[18] && questionsPlayed == 200) {
      badge[18] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge19() {
    if (!badge[19] && revealUsed && answeredCorrectly) {
      badge[19] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge20() {
    if (!badge[20] && deleteUsed && revealUsed && doubleUsed && skipUsed) {
      badge[20] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge21() {
    if (!badge[21] && skipUsed) {
      badge[21] = true;
    }
    setPrefBadges();
    notifyListeners();
  }

  void callAllBadgeFunctions(
      int category, int difficulty, bool tappedOptionIsCorrect) async {
    answeredCorrectly = tappedOptionIsCorrect;
    for (int i = 0; i < badgeName.length; i++) {
      log(badge[i].toString());
    }
    badge0to9(category, difficulty);
    badge10();
    badge11();
    badge12();
    badge13();
    badge14();
    badge15(category, difficulty);
    badge16();
    badge17();
    badge18();
    badge19();
    badge20();
    badge21();

    notifyListeners();
  }

  void setPrefBadges() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < badgeName.length; i++) {
      pref.setBool('badge$i', badge[i]);
    }
  }
}
