class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest({required this.email});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    return data;
  }
}
