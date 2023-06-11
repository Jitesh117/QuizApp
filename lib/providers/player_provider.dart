import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  int highScore = 0;
  String name = "Guest";
  int level = 0;
  int maxStreak = 0;
  int questionPlayed = 0;
  String avatarPath = "assets/userAvatars/memojis/user_profile_0.png";

  void changeAvatar(String imagePath) {
    avatarPath = imagePath;
    notifyListeners();
  }
}
