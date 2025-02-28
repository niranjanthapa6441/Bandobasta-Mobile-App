class CountOfBookedAndCheckInTicketResponse {
  String? code;
  String? message;
  Data? data;

  CountOfBookedAndCheckInTicketResponse({this.code, this.message, this.data});

  CountOfBookedAndCheckInTicketResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? totalBooked;
  int? totalCheckedIn;

  Data({this.totalBooked, this.totalCheckedIn});

  Data.fromJson(Map<String, dynamic> json) {
    totalBooked = json['totalBooked'];
    totalCheckedIn = json['totalCheckedIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalBooked'] = this.totalBooked;
    data['totalCheckedIn'] = this.totalCheckedIn;
    return data;
  }
}
