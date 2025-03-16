class UpdateProfileRequest {
  String firstName;
  String lastName;
  String middleName;
  String email;
  String phoneNumber;

  UpdateProfileRequest(
      {required this.firstName,
      required this.lastName,
      required this.middleName,
      required this.email,
      required this.phoneNumber});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;

    return data;
  }
}
