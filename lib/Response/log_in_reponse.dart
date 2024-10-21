class LogInResponse {
  String? code;
  String? message;
  LoginResponse? data;

  LogInResponse({this.code, this.message, this.data});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data =
        json['data'] != null ? new LoginResponse.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoginResponse {
  String? username;
  String? customerId;
  String? type;
  String? accessToken;

  LoginResponse({this.username, this.customerId, this.type, this.accessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    customerId = json['customerId'];
    type = json['type'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['customerId'] = this.customerId;
    data['type'] = this.type;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
