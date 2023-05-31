class McqModel {
  int? responseCode;
  List<Results>? results;

  McqModel({this.responseCode, this.results});

  McqModel.fromJson(Map<String, dynamic> json) {
    if (json["response_code"] is int) {
      responseCode = json["response_code"];
    }
    if (json["results"] is List) {
      results = json["results"] == null
          ? null
          : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
    }
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
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["difficulty"] is String) {
      difficulty = json["difficulty"];
    }
    if (json["question"] is String) {
      question = json["question"];
    }
    if (json["correct_answer"] is String) {
      correctAnswer = json["correct_answer"];
    }
    if (json["incorrect_answers"] is List) {
      incorrectAnswers = json["incorrect_answers"] == null
          ? null
          : List<String>.from(json["incorrect_answers"]);
    }
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
