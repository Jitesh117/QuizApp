import 'dart:math';

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
  String question = "In which city of Germany is the largest port?";
  String correctAnswer = "";
  List<String> inccorrectAnswer = ["", "", ""];
  bool isLoading = false;
  int rightPosition = 3;

  bool tapped = false;

  List<int> tappedOption = [-1, -1, -1];

  bool tappedOptionIsCorrect = false;
  void printdata(String category) async {
    dev.log("right value at call $rightPosition");
    isLoading = true;
    rightPosition = 3;
    correctAnswer = "Option";
    for (int i = 0; i < 3; i++) {
      inccorrectAnswer[i] = "Option";
      tappedOption[i] = -1;
    }
    rightPosition = Random().nextInt(3);

    tapped = false;

    dev.log("right value after change $rightPosition");
    isLoading = true;

    notifyListeners();

    dev.log("tapped");
    http.Response response;
    response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=1&category=$category&difficulty=hard&type=multiple&token=$token'));
    McqModel jsondata = McqModel.fromJson(json.decode(response.body));

    // ! retrieve a new token
    if (jsondata.responseCode == 3 || jsondata.responseCode == 4) {
      dev.log("response code is: ${jsondata.responseCode}");
      http.Response resetToken = await http
          .get(Uri.parse('https://opentdb.com/api_token.php?command=request'));
      TokenModel tokenModel = TokenModel.fromJson(json.decode(resetToken.body));

      token = tokenModel.token.toString();
      printdata(category);
    } else if (jsondata.responseCode == 0) {
      dev.log(jsondata.results![0].question as String);

      for (int i = 0; i < 3; i++) {
        dev.log(
            "Incorrect answer ${jsondata.results![0].incorrectAnswers![i]}"); // }
      }
      question = jsondata.results![0].question!;
      question = question = Bidi.stripHtmlIfNeeded(question);
      for (int i = 0; i < 3; i++) {
        inccorrectAnswer[i] = jsondata.results![0].incorrectAnswers![i];
        inccorrectAnswer[i] = Bidi.stripHtmlIfNeeded(inccorrectAnswer[i]);
      }

      dev.log("Correct answer: ${jsondata.results![0].correctAnswer!}");
      correctAnswer = jsondata.results![0].correctAnswer!;
      correctAnswer = Bidi.stripHtmlIfNeeded(correctAnswer);
      dev.log(" ");
      isLoading = false;
    } else {
      dev.log("response code is: ${jsondata.responseCode}");

      // ! reset the token
      await http.put(Uri.parse(
          'https://opentdb.com/api_token.php?command=reset&token=41b6053947c596ddfdfe1a5cb973ac0230221af2db62838b9c0522d8c32d03e5'));
      printdata(category);
    }
    notifyListeners();
  }

  void checkTappedOption(int option) {
    tapped = true;
    tappedOption[option] = 1;
    if (option == rightPosition) {
      tappedOptionIsCorrect = true;
    } else {
      tappedOptionIsCorrect = false;
    }
    notifyListeners();
  }
}
