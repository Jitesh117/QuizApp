import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:quiz_v2/Data/models/token_mode.dart';

import 'models/mcq_model.dart';

String token =
    "41b6053947c596ddfdfe1a5cb973ac0230221af2db62838b9c0522d8c32d03e5";
void printdata() async {
  log("tapped");
  http.Response response;
  response = await http.get(Uri.parse(
      'https://opentdb.com/api.php?amount=1&category=10&difficulty=easy&type=multiple&token=$token'));
  McqModel jsondata = McqModel.fromJson(json.decode(response.body));
  // ! retrieve a new token
  if (jsondata.responseCode == 3) {
    log("response code is: ${jsondata.responseCode}");
    http.Response resetToken = await http
        .get(Uri.parse('https://opentdb.com/api_token.php?command=request'));
    TokenModel tokenModel = TokenModel.fromJson(json.decode(resetToken.body));

    token = tokenModel.token.toString();
  } else if (jsondata.responseCode == 0) {
    log(jsondata.results![0].question as String);
    for (int i = 0; i < 3; i++) {
      log("Incorrect answer ${jsondata.results![0].incorrectAnswers![i]}"); // }
    }
    log("Correct answer: ${jsondata.results![0].correctAnswer!}");
    log(" ");
  } else {
    log("response code is: ${jsondata.responseCode}");
    // ! reset the token
    await http.put(Uri.parse(
        'https://opentdb.com/api_token.php?command=reset&token=41b6053947c596ddfdfe1a5cb973ac0230221af2db62838b9c0522d8c32d03e5'));
    printdata();
  }
}
