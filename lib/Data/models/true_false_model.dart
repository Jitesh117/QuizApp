class TrueFalseModel {
  int? responseCode;
  List<Results>? results;

  TrueFalseModel({this.responseCode, this.results});

  TrueFalseModel.fromJson(Map<String, dynamic> json) {
    responseCode = json["response_code"];
    results = json["results"] == null
        ? null
        : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["response_code"] = responseCode;
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  Results(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers});

  Results.fromJson(Map<String, dynamic> json) {
    category = json["category"];
    type = json["type"];
    difficulty = json["difficulty"];
    question = json["question"];
    correctAnswer = json["correct_answer"];
    incorrectAnswers = json["incorrect_answers"] == null
        ? null
        : List<String>.from(json["incorrect_answers"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category"] = category;
    data["type"] = type;
    data["difficulty"] = difficulty;
    data["question"] = question;
    data["correct_answer"] = correctAnswer;
    if (incorrectAnswers != null) {
      data["incorrect_answers"] = incorrectAnswers;
    }
    return data;
  }
}
