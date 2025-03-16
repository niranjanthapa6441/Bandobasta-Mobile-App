class LogInResponse {
  String? code;
  String? message;
  Data? data;

  LogInResponse({this.code, this.message, this.data});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? id;
  String? type;
  String? accessToken;

  Data({this.username, this.id, this.type, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    type = json['type'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['id'] = id;
    data['type'] = type;
    data['accessToken'] = accessToken;
    return data;
  }
}
