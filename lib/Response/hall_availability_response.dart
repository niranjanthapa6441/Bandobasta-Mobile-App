class HallAvailabilityResponse {
  String? code;
  String? message;
  Data? data;

  HallAvailabilityResponse({this.code, this.message, this.data});

  HallAvailabilityResponse.fromJson(Map<String, dynamic> json) {
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
  List<HallAvailabilityDetail>? hallAvailabilityDetails;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data(
      {this.hallAvailabilityDetails,
      this.currentPage,
      this.totalElements,
      this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hallAvailabilityDetails'] != null) {
      hallAvailabilityDetails = <HallAvailabilityDetail>[];
      json['hallAvailabilityDetails'].forEach((v) {
        hallAvailabilityDetails!.add(new HallAvailabilityDetail.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hallAvailabilityDetails != null) {
      data['hallAvailabilityDetails'] =
          this.hallAvailabilityDetails!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class HallAvailabilityDetail {
  String? id;
  String? hallId;
  String? hallName;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  int? capacity;
  String? status;

  HallAvailabilityDetail(
      {this.id,
      this.hallId,
      this.hallName,
      this.description,
      this.date,
      this.startTime,
      this.endTime,
      this.capacity,
      this.status});

  HallAvailabilityDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hallId = json['hallId'];
    hallName = json['hallName'];
    description = json['description'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    capacity = json['capacity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hallId'] = this.hallId;
    data['hallName'] = this.hallName;
    data['description'] = this.description;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['capacity'] = this.capacity;
    data['status'] = this.status;
    return data;
  }
}
