import 'package:flutter/material.dart';

List<String> imagePaths = [
  'assets/anime.png',
  'assets/computer.png',
  'assets/gk.png',
  'assets/geography.png',
  'assets/history.png',
  'assets/movies.png',
  'assets/science.png',
  'assets/sports.png',
  'assets/games.png',
];
List<String> imageBGPaths = [
  'assets/genreImages/indianStates.jpg',
  'assets/genreImages/anime.jpg',
  'assets/genreImages/computer.jpg',
  'assets/genreImages/gk.jpg',
  'assets/genreImages/indianTv.jpg',
  'assets/genreImages/indianMythology.jpg',
  'assets/genreImages/marvel.jpg',
  'assets/genreImages/movies.jpg',
  'assets/genreImages/sports.jpg',
  'assets/genreImages/usTv.jpg',
  'assets/genreImages/indianCartoon.jpg',
];

List<String> genreNames = [
  'Indian States',
  'Anime',
  'Computer',
  'GK',
  'Indian TV Shows',
  'Indian Mythology',
  'Marvel',
  'Movies',
  'Sports',
  'US TV Shows',
  'Indian Cartoon',
  'American Pop',
];
Map<int, String> categories = {
  0: "IndianStates",
  1: "Anime",
  2: "computer",
  3: "GK",
  4: "IndianTV",
  5: "IndianMythology",
  6: "Marvel",
  7: "movies",
  8: "sports",
  9: "UsTV",
  10: "IndianCartoons",
  11: "PopSongs"
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
  const Color(0xFF21D6AC),
  const Color(0xffe55039),
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
  'Reveals the correct option',
  'Doubles the coins',
  'Skips current question',
];
