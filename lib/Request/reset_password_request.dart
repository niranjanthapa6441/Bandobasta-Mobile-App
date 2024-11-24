class ResetPasswordRequest {
  String email;
  String otp;
  String password;

  ResetPasswordRequest(
      {required this.email, required this.otp, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['otp'] = otp;
    data['password'] = password;
    return data;
  }
}
