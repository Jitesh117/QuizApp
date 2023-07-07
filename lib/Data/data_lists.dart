import 'package:flutter/material.dart';

List<String> genreNames = [
  'Indian States',
  'Anime',
  'Computer',
  'GK',
  'Science',
  'Marvel',
  'Movies',
  'Sports',
  'US TV Shows',
  'American Pop',
];
Map<int, String> categories = {
  0: "IndianStates",
  1: "Anime",
  2: "computer",
  3: "GK",
  4: "science",
  5: "Marvel",
  6: "movies",
  7: "sports",
  8: "UsTV",
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
  const Color(0xFFFF9800),
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

List<Color> powerupColor = [
  Colors.pinkAccent.shade200,
  Colors.greenAccent.shade400,
  Colors.yellow.shade400,
  Colors.blueAccent,
];

List<String> powerDescription = [
  'Removes a wrong option',
  'Reveals the answer',
  'Doubles the coins',
  'Skips current question',
];

List<String> badgeName = [
  // badge 0
  "The Silent Cartographer",
  // badge 1
  "Otaku",
  // badge 2
  "Geek",
  // badge 3
  "Know-It-All Extraordinaire",
  // badge 4
  "You know, I'm something of a scientist myself!",
  // badge 5
  "MCU Fanatic",
  // badge 6
  "Cinema Buff",
  // badge 7
  "Jock of all Trades",
  // badge 8
  "What's all your furniture pointed at?",
  // badge 9
  "Pop Patriot",
  // badge 10
  "Quiz Ninja",
  // badge 11
  "The Oracle",
  // badge 12
  "Professional Clown",
  // badge 13
  "The Braniac",
  // badge 14
  "The Know it All",
  // badge 15
  "Master of Trivia",
  // badge 16
  "Speed Demon",
  // badge 17
  "Prepare for Trouble, and Make it Double",
  // badge 18
  "Lucky Break",
  // badge 19
  "The Grand Challenge",
  // badge 20
  "Power Junkie",
  // badge 21
  "Ninja Skipper"
];

List<String> badgeDescription = [
  // category badges
  // badge 0
  "Answer 10 questions correctly in a row across all difficulties in the category 'Indian States'",
  // badge 1
  "Answer 10 questions correctly in a row across all difficulties in the category 'Anime'",
  // badge 2
  "Answer 10 questions correctly in a row across all difficulties in the category 'Computers'",
  // badge 3
  "Answer 10 questions correctly in a row across all difficulties in the category 'GK'",
  // badge 4
  "Answer 10 questions correctly in a row across all difficulties in the category 'Science'",
  // badge 5
  "Answer 10 questions correctly in a row across all difficulties in the category 'Marvel'",
  // badge 6
  "Answer 10 questions correctly in a row across all difficulties in the category 'Movies'",
  // badge 7
  "Answer 10 questions correctly in a row across all difficulties in the category 'Sports'",
  // badge 8
  "Answer 10 questions correctly in a row across all difficulties in the category 'US TV Shows'",
  // badge 9
  "Answer 10 questions correctly in a row across all difficulties in the category 'American Pop'",
  //! misc. badges
  // badge 10
  "Answer 10 questions correctly in a row within the first 3 seconds of each question",
  // badge 11
  "Correctly predict the next answer before the question appears on the screen",
  // badge 12
  "Answer a question wrong after using the 'Reveal correct option' powerup",
  // badge 13
  "Answer 25 questions correctly in a row without making a mistake in any category",
  // badge 14
  "Achieve a perfect streak of 10 in all categories and difficulties",
  // badge 15
  "Play quiz in all 10 categories at least once",
  // badge 16
  "Complete a quiz with a streak of 10 within a 10 seconds time",
  // badge 17
  "Score max points on a question after using the 'Double the points' powerup",
  // badge 18
  "Use the 'Reveal the answer' powerup and answer it correctly",
  // badge 19
  "Answer 500 questions correctly across all categories and difficulties",
  // badge 20
  "Use all 4 powerups in a single question",
  // badge 21
  "Use the skip powerup on a question within the first 3 seconds",
];
