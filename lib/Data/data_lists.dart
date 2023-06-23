import 'package:flutter/material.dart';


List<String> genreNames = [
  'Indian States',
  'Anime',
  'Computer',
  'GK',
  // 'Indian TV Shows',
  'Indian Mythology',
  'Marvel',
  'Movies',
  'Sports',
  'US TV Shows',
  // 'Indian Cartoon',
  'American Pop',
];
Map<int, String> categories = {
  0: "IndianStates",
  1: "Anime",
  2: "computer",
  3: "GK",
  // 4: "IndianTV",
  4: "IndianMythology",
  5: "Marvel",
  6: "movies",
  7: "sports",
  8: "UsTV",
  // 10: "IndianCartoons",
  9: "PopSongs"
};

List<Color> difficultyColorOne = [
  Colors.lightGreenAccent.shade100,
  Colors.orangeAccent.shade100,
  Colors.redAccent.shade100,
];
List<Color> difficultyColorTwo = [
  Colors.lightGreen,
  Colors.orangeAccent,
  Colors.redAccent,
];

List<Color> difficultyColorThree = [
  Colors.green,
  Colors.orange,
  Colors.red,
];

List<Color> genreColor = [
  const Color(0xffFFC312),
  const Color(0xff12CBC4),
  const Color(0xffD980FA),
  const Color(0xffEA2027),
  const Color(0xFFC95BAF),
  const Color(0xFF0B8FED),
  const Color(0xff72CFC6),
  const Color(0xffA3CB38),
  const Color(0xFF6163D5),
  // const Color(0xFF21D6AC),
  // const Color(0xffe55039),
  Colors.orange,
];

List<Color> optionColor = [
  Colors.pink,
  Colors.orange,
  Colors.blue,
];

List<String> powerups = [
  'assets/powerups/one.png',
  'assets/powerups/two.png',
  'assets/powerups/three.png',
  'assets/powerups/four.png',
];

List<String> powerDescription = [
  'Removes a wrong option',
  'Reveals the answer' ,
  'Doubles the coins',
  'Skips current question',
];
