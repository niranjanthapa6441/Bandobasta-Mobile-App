class VenueResponse {
  String? code;
  String? message;
  Data? data;

  VenueResponse({this.code, this.message, this.data});

  VenueResponse.fromJson(Map<String, dynamic> json) {
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
  List<Venue>? venues;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data({this.venues, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['venues'] != null) {
      venues = <Venue>[];
      json['venues'].forEach((v) {
        venues!.add(new Venue.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.venues != null) {
      data['venues'] = this.venues!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Venue {
  String? name;
  String? address;
  String? description;
  String? status;
  String? startingPrice;
  List<String>? venueImagePaths;
  List<HallDetails>? hallDetails;

  Venue(
      {this.name,
      this.address,
      this.description,
      this.status,
      this.startingPrice,
      this.venueImagePaths,
      this.hallDetails});

  Venue.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    startingPrice = json['startingPrice'];
    venueImagePaths = json['venueImagePaths'].cast<String>();
    if (json['hallDetails'] != null) {
      hallDetails = <HallDetails>[];
      json['hallDetails'].forEach((v) {
        hallDetails!.add(new HallDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    data['status'] = this.status;
    data['startingPrice'] = this.startingPrice;
    data['venueImagePaths'] = this.venueImagePaths;
    if (this.hallDetails != null) {
      data['hallDetails'] = this.hallDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HallDetails {
  Null? venueId;
  int? id;
  String? name;
  String? description;
  int? floorNumber;
  int? capacity;
  String? status;
  List<String>? hallImagePaths;

  HallDetails(
      {this.venueId,
      this.id,
      this.name,
      this.description,
      this.floorNumber,
      this.capacity,
      this.status,
      this.hallImagePaths});

  HallDetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venueId'] = this.venueId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['floorNumber'] = this.floorNumber;
    data['capacity'] = this.capacity;
    data['status'] = this.status;
    data['hallImagePaths'] = this.hallImagePaths;
    return data;
  }
}
