import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_v2/Data/data_lists.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:quiz_v2/Data/models/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// question number controlling parameters
  int previousCategory = -1;
  int previousDifficulty = -1;
  int questionNumber = 0;
  bool questionsLoaded = false;

  int streakCount = 0;
  bool tappedOptionIsCorrect = false;
  bool previousAnswerWasCorrect = false;

  List<List<DataModel>> dataModels = List.generate(
      genreNames.length, (index) => List.generate(3, (index) => DataModel()));

  List<List<String>> badgesEarned = List.generate(
      genreNames.length, (index) => List.generate(3, (index) => "0"));

  void loadQuestions() async {
    questionsLoaded = false;
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
    // logged the value for checking whether the values are getting initialised or not
    // for (int i = 0; i < categoryNames.length; i++) {
    //   for (int j = 0; j < 3; j++) {
    //     for (int k = 0; k < dataModels[i][j].results!.length; k++) {
    //       dev.log(
    //           "${dataModels[i][j].results![k].category!} ${dataModels[i][j].results![k].difficulty} ${dataModels[i][j].results![k].question!}");
    //     }
    //   }
    // }
    questionsLoaded = true;
    notifyListeners();
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
    int itemNumber =
        Random().nextInt(dataModels[category][difficulty].results!.length);

    tapped = false;
    timesTapped = 0;

    dev.log("right value after change $rightPosition");

    question = dataModels[category][difficulty].results![itemNumber].question!;
    question = question = Bidi.stripHtmlIfNeeded(question);
    dev.log(question);

    correctAnswer =
        dataModels[category][difficulty].results![itemNumber].correctAnswer!;
    correctAnswer = Bidi.stripHtmlIfNeeded(correctAnswer);
    for (int i = 0; i < 3; i++) {
      incorrectAnswer[i] = dataModels[category][difficulty]
          .results![itemNumber]
          .incorrectAnswers![i];
      incorrectAnswer[i] = Bidi.stripHtmlIfNeeded(incorrectAnswer[i]);
      dev.log("Incorrect answer $i: ${incorrectAnswer[i]}");
    }
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
    } else {
      tappedOptionIsCorrect = false;
      previousAnswerWasCorrect = false;
    }
    streakChanger();
    notifyListeners();
  }

  void streakChanger() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (int i = 0; i < categoryNames.length; i++) {
      badgesEarned[i] =
          pref.getStringList("category$i") ?? List.generate(3, (index) => '0');
    }
    // for (int i = 0; i < categoryNames.length; i++) {
    //   for (int j = 0; j < 3; j++) {
    //     dev.log("${badgesEarned[i][j]} ");
    //   }
    // }
    if (tappedOptionIsCorrect && timesTapped == 1) {
      streakCount++;
      if (badgesEarned[previousCategory][previousDifficulty] == '0' &&
          streakCount == 10) {
        badgesEarned[previousCategory][previousDifficulty] = '1';
        pref.setStringList(
            "category$previousCategory", badgesEarned[previousCategory]);
        // confettiController.play();
      }
      if (streakCount % 10 == 0) {
        confettiController.play();
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
          title: const Text(
            "Do you want to go back? You'll lose all your progess!",
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
                streakCount = 0;
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
}
