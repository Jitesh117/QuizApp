import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:quiz_v2/UI/Home/achievements.dart';
import 'package:quiz_v2/UI/Widgets/playerProfile/animated_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerProvider with ChangeNotifier {
  int highScore = 0;
  String name = "Guest";
  int level = 0;
  int points = 100;
  String avatarPath = "assets/userAvatars/memojis/user_profile_0.png";

  bool soundShouldPlay = true;
  bool musicShouldPlay = true;
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

  void resetPowerups() {
    deleteUsed = false;
    revealUsed = false;
    doubleUsed = false;
    skipUsed = false;
    notifyListeners();
  }

  void updatePowerups() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('powerDelete', powerDelete);
    pref.setInt('powerReveal', powerReveal);
    pref.setInt('powerDouble', powerDouble);
    pref.setInt('powerSkip', powerSkip);
    pref.setInt('points', points);
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
    if (soundShouldPlay) {
      final player = AudioPlayer();
      player.setVolume(0.5);
      player.play(AssetSource('sounds/ding.mp3'));
    }
  }

  void toggleSoundButton() {
    soundShouldPlay = !soundShouldPlay;
    notifyListeners();
  }
// achievement unlock functions

  void badgeUnlocked(int badgeNumber, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AnimatedBadge(
        badge: AchievementBadge(
          imagePath: 'assets/badges/$badgeNumber.png',
          unlocked: true,
        ),
      ),
    );
  }

  void badge0to9(int category, int difficulty, BuildContext context) {
    if (!badge[category]) {
      if (currentStreak == 10) {
        categoryDifficultyPlayed[category][difficulty] = true;
        bool allCompleted = true;
        for (int i = 0; i < categoryDifficultyPlayed[category].length; i++) {
          allCompleted = allCompleted && categoryDifficultyPlayed[category][i];
        }
        if (allCompleted) {
          badge[category] = true;
          showSnackBar(context, category);
        }
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge10(BuildContext context) {
    if (!badge[10]) {
      if (timeTaken <= 3 && answeredCorrectly) {
        threeSecondStreak++;
        if (threeSecondStreak == 10) {
          badge[10] = true;
          showSnackBar(context, 10);
        }
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge11(BuildContext context) {
    if (!badge[11] && timeTaken <= 1 && answeredCorrectly) {
      badge[11] = true;
      showSnackBar(context, 11);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge12(BuildContext context) {
    if (!badge[12] && revealUsed && !answeredCorrectly) {
      badge[12] = true;
      showSnackBar(context, 12);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge13(BuildContext context) {
    if (!badge[13] && currentStreak == 25) {
      badge[13] = true;
      showSnackBar(context, 13);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge14(BuildContext context) {
    if (!badge[14]) {
      bool allCompleted = true;
      for (int i = 0; i < genreNames.length; i++) {
        allCompleted = allCompleted && badge[i];
      }
      if (allCompleted) {
        badge[14] = true;
        showSnackBar(context, 14);
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge15(int category, int difficulty, BuildContext context) {
    if (!badge[15]) {
      categoryPlayed[category] = true;
      bool allCompleted = true;
      for (int i = 0; i < genreNames.length; i++) {
        allCompleted = allCompleted && categoryPlayed[i];
      }
      if (allCompleted) {
        badge[15] = true;
        showSnackBar(context, 15);
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge16(BuildContext context) {
    if (!badge[16]) {
      if (currentStreak == 10 && totalTimeTaken <= 10) {
        badge[16] = true;
        showSnackBar(context, 16);
      }
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge17(BuildContext context) {
    if (!badge[17] && doubleUsed && answeredCorrectly) {
      badge[17] = true;
      showSnackBar(context, 17);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge18(BuildContext context) {
    if (!badge[18] && revealUsed && answeredCorrectly) {
      badge[18] = true;
      showSnackBar(context, 18);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge19(BuildContext context) {
    if (!badge[19] && questionsPlayed == 200) {
      badge[19] = true;
      showSnackBar(context, 19);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge20(BuildContext context) {
    if (!badge[20] && deleteUsed && revealUsed && doubleUsed && skipUsed) {
      badge[20] = true;
      showSnackBar(context, 20);
    }
    setPrefBadges();
    notifyListeners();
  }

  void badge21(BuildContext context) {
    if (!badge[21] && skipUsed) {
      badge[21] = true;
      showSnackBar(context, 21);
    }
    setPrefBadges();
    notifyListeners();
  }

  void showSnackBar(BuildContext context, int index)  {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 20),
      content: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Center(
                child: Image.asset(
                  'assets/badges/$index.png',
                  height: 50,
                ),
              ),
            ),
            const Text(
              'Achievement Unlocked!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    final player = AudioPlayer();
    player.setVolume(1);
     player.play(AssetSource('sounds/achievement.wav'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void callAllBadgeFunctions(int category, int difficulty,
      bool tappedOptionIsCorrect, BuildContext context) async {
    answeredCorrectly = tappedOptionIsCorrect;
    for (int i = 0; i < badgeName.length; i++) {
      log("badge$i: ${badge[i]}");
    }
    badge0to9(category, difficulty, context);
    badge10(context);
    badge11(context);
    badge12(context);
    badge13(context);
    badge14(context);
    badge15(category, difficulty, context);
    badge16(context);
    badge17(context);
    badge18(context);
    badge19(context);
    badge20(context);
    badge21(context);

    notifyListeners();
  }

  void setPrefBadges() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < badgeName.length; i++) {
      pref.setBool('badge$i', badge[i]);
    }
  }
}
