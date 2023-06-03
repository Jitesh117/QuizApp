import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:quiz_v2/Data/models/token_model.dart';

import '../Data/models/mcq_model.dart';

class QuesProvider with ChangeNotifier {
  String token =
      "41b6053947c596ddfdfe1a5cb973ac0230221af2db62838b9c0522d8c32d03e5";
  String question = "In which city of Germany is the largest port?";
  String correctAnswer = "";
  String inCorrectAnswerOne = "";
  String inCorrectAnswerTwo = "";
  bool isLoading = false;

  void printdata(String category) async {
    isLoading = true;
    correctAnswer = "Option 2";
    inCorrectAnswerOne = "Option 1";
    inCorrectAnswerTwo = "Option 3";
    notifyListeners();

    log("tapped");
    http.Response response;
    response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=1&category=$category&difficulty=easy&type=multiple&token=$token'));
    McqModel jsondata = McqModel.fromJson(json.decode(response.body));

    // ! retrieve a new token
    if (jsondata.responseCode == 3) {
      log("response code is: ${jsondata.responseCode}");
      http.Response resetToken = await http
          .get(Uri.parse('https://opentdb.com/api_token.php?command=request'));
      TokenModel tokenModel = TokenModel.fromJson(json.decode(resetToken.body));

      token = tokenModel.token.toString();
      printdata(category);
    } else if (jsondata.responseCode == 0) {
      log(jsondata.results![0].question as String);
      for (int i = 0; i < 3; i++) {
        log("Incorrect answer ${jsondata.results![0].incorrectAnswers![i]}"); // }
      }
      question = jsondata.results![0].question!;
      inCorrectAnswerOne = jsondata.results![0].incorrectAnswers![0];
      inCorrectAnswerTwo = jsondata.results![0].incorrectAnswers![1];
      log("Correct answer: ${jsondata.results![0].correctAnswer!}");
      correctAnswer = jsondata.results![0].correctAnswer!;
      log(" ");
      isLoading = false;
    } else {
      log("response code is: ${jsondata.responseCode}");

      // ! reset the token
      await http.put(Uri.parse(
          'https://opentdb.com/api_token.php?command=reset&token=41b6053947c596ddfdfe1a5cb973ac0230221af2db62838b9c0522d8c32d03e5'));
      printdata(category);
    }
    notifyListeners();
  }
}
