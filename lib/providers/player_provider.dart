import 'package:flutter/material.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerProvider with ChangeNotifier {
  int highScore = 0;
  String name = "Guest";
  int level = 0;
  int maxStreak = 0;
  int questionsPlayed = 0;
  int points = 100;
  String avatarPath = "assets/userAvatars/memojis/user_profile_0.png";
  int powerDelete = 2;
  int powerReveal = 2;
  int powerDouble = 2;
  int powerSkip = 2;
  bool shouldDoublePoints = false;

  // variables for storing badges information
  List<List<String>> badgesEarned = List.generate(
      genreNames.length, (index) => List.generate(3, (index) => "0"));

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
    for (int i = 0; i < genreNames.length; i++) {
      badgesEarned[i] =
          pref.getStringList("category$i") ?? List.generate(3, (index) => '0');
    }
    notifyListeners();
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
      if (shouldDoublePoints) {
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('powerDelete', powerDelete);
    pref.setInt('powerReveal', powerReveal);
    pref.setInt('powerDouble', powerDouble);
    pref.setInt('powerSkip', powerSkip);
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
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {},
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
}
