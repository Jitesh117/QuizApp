import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:quiz_v2/Data/models/token_model.dart';

import '../Data/models/mcq_model.dart';

class QuesProvider with ChangeNotifier {
  String token =
      "41b6053947c596ddfdfe1a5cb973ac0230221af2db62838b9c0522d8c32d03e5";
  ConfettiController confettiController = ConfettiController();
  // initialisation of question and answers
  String question = "";
  String correctAnswer = "";
  List<String> incorrectAnswer = ["", "", ""];
  bool isLoading = false;
  int rightPosition = 3;

//  used for changing option tile's appearance
  bool tapped = false;
  int timesTapped = 0;
  List<int> tappedOption = [-1, -1, -1];

  // CountDownController timeController = CountDownController();

// question number controlling parameters
  String previousCategory = "";
  String previousDifficulty = "";
  int questionNumber = 1;

  int streakCount = 0;
  bool tappedOptionIsCorrect = false;

  void fetchQuestion(String category, String difficulty) async {
//  reset the countdown timer
//     timeController = CountDownController();
//     timeController.start();
//     timeController.reset();

    dev.log("right value at call $rightPosition");
    if (previousCategory != category || previousDifficulty != difficulty) {
      questionNumber = 1;
      previousCategory = category;
      previousDifficulty = difficulty;
    }

    isLoading = true;
    rightPosition = 3;
    correctAnswer = "Option";
    for (int i = 0; i < 3; i++) {
      incorrectAnswer[i] = "Option";
      tappedOption[i] = -1;
    }
    rightPosition = Random().nextInt(3);

    tapped = false;
    timesTapped = 0;

    dev.log("right value after change $rightPosition");
    isLoading = true;

    notifyListeners();

    dev.log("tapped");
    http.Response response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=1&category=$category&difficulty=$difficulty&type=multiple&token=$token'));
    McqModel jsondata = McqModel.fromJson(json.decode(response.body));

    // ! retrieve a new token
// Code 0: Success Returned results successfully.
// Code 1: No Results Could not return results. The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)
// Code 2: Invalid Parameter Contains an invalid parameter. Arguements passed in aren't valid. (Ex. Amount = Five)
// Code 3: Token Not Found Session Token does not exist.
// Code 4: Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary.
    if (jsondata.responseCode == 3) {
      dev.log("response code is: ${jsondata.responseCode}");
      http.Response resetToken = await http
          .get(Uri.parse('https://opentdb.com/api_token.php?command=request'));
      TokenModel tokenModel = TokenModel.fromJson(json.decode(resetToken.body));

      token = tokenModel.token.toString();
      fetchQuestion(category, difficulty);
    } else if (jsondata.responseCode == 0) {
      dev.log(jsondata.results![0].question as String);

      for (int i = 0; i < 3; i++) {
        dev.log(
            "Incorrect answer ${jsondata.results![0].incorrectAnswers![i]}"); // }
      }
      question = jsondata.results![0].question!;
      question = question = Bidi.stripHtmlIfNeeded(question);
      for (int i = 0; i < 3; i++) {
        incorrectAnswer[i] = jsondata.results![0].incorrectAnswers![i];
        incorrectAnswer[i] = Bidi.stripHtmlIfNeeded(incorrectAnswer[i]);
      }
      // ! start the countdown timer
      // if (incorrectAnswer[0] != "Option") {
      //   timeController.start();
      // }

      dev.log("Correct answer: ${jsondata.results![0].correctAnswer!}");
      correctAnswer = jsondata.results![0].correctAnswer!;
      correctAnswer = Bidi.stripHtmlIfNeeded(correctAnswer);
      dev.log(" ");
      isLoading = false;
    }
    // token empty
    else if (jsondata.responseCode == 4) {
      dev.log("response code is: ${jsondata.responseCode}");

      // ! reset the token
      await http.put(Uri.parse(
          'https://opentdb.com/api_token.php?command=reset&token=$token'));
      fetchQuestion(category, difficulty);
    }
    notifyListeners();
  }

  void checkTappedOption(int option) {
    tapped = true;
    timesTapped++;
    tappedOption[option] = 1;
    if (option == rightPosition) {
      tappedOptionIsCorrect = true;
    } else {
      tappedOptionIsCorrect = false;
    }
    streakChanger();
    notifyListeners();
  }

  void streakChanger() {
    if (tappedOptionIsCorrect && timesTapped == 1) {
      streakCount++;
      if (streakCount % 10 == 0) {
        confettiController.play();
      }
    } else if (!tappedOptionIsCorrect && timesTapped == 1) {
      streakCount = 0;
    }
    notifyListeners();
  }

  void questionNumberChanger(String category, String difficulty) {
    confettiController.stop();
    if (previousCategory == "" ||
        (previousCategory == category && previousDifficulty == difficulty)) {
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
}
