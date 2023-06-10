import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int highScore = 0;
  String name = "Guest";
  int level = 0;
  int maxStreak = 0;
  int questionPlayed = 0;
  
}
