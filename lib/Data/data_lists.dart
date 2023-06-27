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
  'Reveals the answer',
  'Doubles the coins',
  'Skips current question',
];

List<String> badgeName = [
  "The Silent Cartographer",
  "Otaku",
  "Geek",
  "Know-It-All Extraordinaire",
  "The Enlightened One",
  "MCU Fanatic",
  "Cinema Buff",
  "Jock of all Trades",
  "What's all your furniture pointed at?",
  "Pop Patriot",
  "Quiz Ninja",
  "The Oracle",
  "Unnstoppable",
  "The Braniac",
  "The Know it All",
  "Speed Demon",
  "Prepare for Trouble, and Make it Double",
  "Master of Trivia",
  "Lucky Break",
  "The Grand Challenge",
  "Power Junkie",
  "Ninja Skipper"
];

List<String> badgeDescription = [
  "Answer 10 questions correctly across all difficulties in the category 'Indian States'",
  "Answer 10 questions correctly across all difficulties in the category 'Anime'",
  "Answer 10 questions correctly across all difficulties in the category 'Computers'",
  "Answer 10 questions correctly across all difficulties in the category 'GK'",
  "Answer 10 questions correctly across all difficulties in the category 'Indian Mythology'",
  "Answer 10 questions correctly across all difficulties in the category 'Marvel'",
  "Answer 10 questions correctly across all difficulties in the category 'Movies'",
  "Answer 10 questions correctly across all difficulties in the category 'Sports'",
  "Answer 10 questions correctly across all difficulties in the category 'US TV Shows'",
  "Answer 10 questions correctly across all difficulties in the category 'American Pop'",
  "Answer 10 questions correctly wihin the first 3 seconds of each question",
  "Correctly predict the next answer before the question appears on the screen",
  "Answer a question wrong after using the 'Reveal correct option' powerup",
  "Answer 25 questions correctly in a row without making a mistake",
  "Achieve a perfect streak of 10 in all categories and difficulties",
  "Play quz in all 10 categoies at least once",
  "Complete a quiz with a streak of 10 within a 10 seconds time",
  "Score max points on a question after using the 'Double the points' powerup",
  "Answer 200 questions correctly across all categories and difficulties",
  "Use the 'Reveal the answer' powerup and answer it correctly",
  "Use all 4 powerups in a single question",
  "Use the skip powerup on a question within the first 3 seconds",
];
