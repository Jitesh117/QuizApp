class TokenModel {
  int? responseCode;
  String? responseMessage;
  String? token;

  TokenModel({this.responseCode, this.responseMessage, this.token});

  TokenModel.fromJson(Map<String, dynamic> json) {
    responseCode = json["response_code"];
    responseMessage = json["response_message"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["response_code"] = responseCode;
    data["response_message"] = responseMessage;
    data["token"] = token;
    return data;
  }
}
