class VenueHallResponse {
  String? code;
  String? message;
  Data? data;

  VenueHallResponse({this.code, this.message, this.data});

  VenueHallResponse.fromJson(Map<String, dynamic> json) {
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
  List<HallDetail>? hallDetails;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data(
      {this.hallDetails,
      this.currentPage,
      this.totalElements,
      this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hallDetails'] != null) {
      hallDetails = <HallDetail>[];
      json['hallDetails'].forEach((v) {
        hallDetails!.add(HallDetail.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hallDetails != null) {
      data['hallDetails'] = hallDetails!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    return data;
  }
}

class HallDetail {
  String? venueId;
  int? id;
  String? name;
  String? description;
  int? floorNumber;
  int? capacity;
  String? status;
  List<String>? hallImagePaths;

  HallDetail(
      {this.venueId,
      this.id,
      this.name,
      this.description,
      this.floorNumber,
      this.capacity,
      this.status,
      this.hallImagePaths});

  HallDetail.fromJson(Map<String, dynamic> json) {
    venueId = json['venueId'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    floorNumber = json['floorNumber'];
    capacity = json['capacity'];
    status = json['status'];
    hallImagePaths = json['hallImagePaths'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['venueId'] = venueId;
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['floorNumber'] = floorNumber;
    data['capacity'] = capacity;
    data['status'] = status;
    data['hallImagePaths'] = hallImagePaths;
    return data;
  }
}
