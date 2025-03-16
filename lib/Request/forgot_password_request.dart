class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest({required this.email});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
