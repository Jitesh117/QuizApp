import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:quiz_v2/Data/models/data_model.dart';

import '../UI/Styles/text_styles.dart';

class QuesProvider with ChangeNotifier {
  ConfettiController confettiController = ConfettiController();
  // initialisation of question and answers
  String question = "";
  String correctAnswer = "";
  List<String> incorrectAnswer = ["", "", ""];
  int rightPosition = 3;

//  used for changing option tile's appearance
  bool tapped = false;
  int timesTapped = 0;
  List<int> tappedOption = [-1, -1, -1];
  bool showCorrectOption = false;

  int numberOfCorrectAnswers = 0;
  int numberOfInorrectAnswers = 0;

  String? currentTime = '0';

// question number controlling parameters
  int previousCategory = -1;
  int previousDifficulty = -1;
  int questionNumber = 0;
  bool questionsLoaded = false;

// powerups parameters
  bool deleteWrongOptionTapped = false;
  bool revealRightOptionTapped = false;
  bool doublePointsTapped = false;

  int streakCount = 0;
  bool tappedOptionIsCorrect = false;
  bool previousAnswerWasCorrect = false;
  int numberOfPowerupsUsed = 0;

  List<List<DataModel>> dataModels = List.generate(
      genreNames.length, (index) => List.generate(3, (index) => DataModel()));

  List<List<String>> badgesEarned = List.generate(
      genreNames.length, (index) => List.generate(3, (index) => "0"));

  late List<List<List<int>>> randomQuestions = [];
//  List.generate(
//       genreNames.length, (index) => List.generate(3, (index) => []));

  void loadQuestions() async {
    questionsLoaded = false;
    randomQuestions = List.generate(
        genreNames.length, (index) => List.generate(3, (index) => []));
    for (int i = 0; i < genreNames.length; i++) {
      String easy = await rootBundle
          .loadString("assets/QuestionData/${categories[i]}/easy.json");
      String medium = await rootBundle
          .loadString("assets/QuestionData/${categories[i]}/medium.json");
      String hard = await rootBundle
          .loadString("assets/QuestionData/${categories[i]}/hard.json");
      DataModel easyData = DataModel.fromJson(json.decode(easy));
      DataModel mediumData = DataModel.fromJson(json.decode(medium));
      DataModel hardData = DataModel.fromJson(json.decode(hard));
      dataModels[i][0] = easyData;
      dataModels[i][1] = mediumData;
      dataModels[i][2] = hardData;
    }

    addRandomQuestions();
    notifyListeners();
  }

  void addRandomQuestions() {
    for (int i = 0; i < genreNames.length; i++) {
      for (int j = 0; j < 3; j++) {
        for (int k = 0; k < dataModels[i][j].results!.length; k++) {
          randomQuestions[i][j].add(k);
        }
        randomQuestions[i][j].shuffle();
      }
    }
  }

  void fetchQuestion(int category, int difficulty) {
    dev.log("category: $category");
    dev.log("difficulty: $difficulty");
    dev.log("right value at call $rightPosition");
    questionNumberChanger(category, difficulty);

    rightPosition = 3;
    correctAnswer = "Option";
    for (int i = 0; i < 3; i++) {
      incorrectAnswer[i] = "Option";
      tappedOption[i] = -1;
    }
    rightPosition = Random().nextInt(3);

    if (randomQuestions[category][difficulty].isEmpty) {
      loadQuestions();
      addRandomQuestions();
      // fetchQuestion(category, difficulty);
    }
    int itemNumber = randomQuestions[category][difficulty].last;
    randomQuestions[category][difficulty].removeLast();

    tapped = false;
    timesTapped = 0;
    tappedOptionIsCorrect = false;
    deleteWrongOptionTapped = false;
    revealRightOptionTapped = false;
    doublePointsTapped = false;
    questionsLoaded = false;
    showCorrectOption = false;

    question = dataModels[category][difficulty].results![itemNumber].question!;
    dev.log(question);

    correctAnswer =
        dataModels[category][difficulty].results![itemNumber].correctAnswer!;
    for (int i = 0; i < 3; i++) {
      incorrectAnswer[i] = dataModels[category][difficulty]
          .results![itemNumber]
          .incorrectAnswers![i];
      dev.log("Incorrect answer $i: ${incorrectAnswer[i]}");
    }
    questionsLoaded = true;
    dev.log("Correct answer : $correctAnswer");
    notifyListeners();
  }

  void checkTappedOption(int option) {
    tapped = true;
    timesTapped++;
    tappedOption[option] = 1;
    if (option == rightPosition) {
      tappedOptionIsCorrect = true;
      previousAnswerWasCorrect = true;
      numberOfCorrectAnswers++;
    } else {
      tappedOptionIsCorrect = false;
      previousAnswerWasCorrect = false;
      numberOfInorrectAnswers++;
    }
    streakChanger();
    notifyListeners();
  }

  void confettiPlay() async {
    confettiController.play();
    final player = AudioPlayer();
    player.setVolume(0.1);
    player.play(AssetSource('sounds/confetti.mp3'));
    await Future.delayed(
      const Duration(milliseconds: 200),
      () {
        confettiController.stop();
      },
    );
  }

  void streakChanger() async {
    if (tappedOptionIsCorrect && timesTapped == 1) {
      streakCount++;
      if (streakCount % 10 == 0) {
        // confettiController.play();
        confettiPlay();
      }
    } else if (!tappedOptionIsCorrect && timesTapped == 1) {
      streakCount = 0;
      notifyListeners();
    }
  }

  void questionNumberChanger(int category, int difficulty) {
    confettiController.stop();
    if (previousCategory == category && previousDifficulty == difficulty) {
      questionNumber++;
      previousCategory = category;
      previousDifficulty = difficulty;
    } else {
      questionNumber = 1;
      previousCategory = category;
      previousDifficulty = difficulty;
    }
    dev.log("question number: $questionNumber");
    notifyListeners();
  }

  Future<bool> popOrNot(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            textScaleFactor: ScaleSize.textScaleFactor(context),
            "Do you want to go back? You'll lose all your progess!",
            style: regularBold,
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                playTapSound();
                Navigator.pop(context, false);
              },
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                'No',
                style: redBold,
              ),
            ),
            TextButton(
              onPressed: () {
                playTapSound();
                streakCount = 0;
                numberOfCorrectAnswers = 0;
                numberOfInorrectAnswers = 0;
                numberOfPowerupsUsed = 0;
                // reset double Streak
                doublePointsTapped = false;
                notifyListeners();
                Navigator.pop(context, true);
              },
              child: Text(
                textScaleFactor: ScaleSize.textScaleFactor(context),
                'Yes',
                style: greenBold,
              ),
            ),
          ],
        );
      },
    );
    return shouldPop!;
  }

  void deleteWrongOption() {
    deleteWrongOptionTapped = true;
    int randomWrongPosition = Random().nextInt(2);
    if (rightPosition == 0) {
      incorrectAnswer[randomWrongPosition + 1] = "";
    } else if (rightPosition == 1) {
      if (randomWrongPosition == 0) {
        incorrectAnswer[0] = "";
      } else {
        incorrectAnswer[2] = "";
      }
    } else {
      incorrectAnswer[randomWrongPosition] = "";
    }
    notifyListeners();
  }

  void revealCorrectOption() {
    showCorrectOption = true;
    notifyListeners();
  }

  void doublePoints() {
    if (!doublePointsTapped) {
      doublePointsTapped = true;
      notifyListeners();
    }
  }

  Future showDialogue(BuildContext context, String animationPath) async {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        height: 150,
        width: 150,
        child: Lottie.asset(
          animationPath,
        ),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
      },
    );
  }

  void playTapSound() {
    final player = AudioPlayer();
    player.setVolume(0.1);
    player.play(AssetSource('sounds/ding.mp3'));
  }
}
