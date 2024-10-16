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
  String? id;
  String? name;
  String? address;
  String? description;
  String? status;
  String? startingPrice;
  List<String>? venueImagePaths;
  String? maxCapacity;
  List<String>? amenities;

  Venue(
      {this.id,
      this.name,
      this.address,
      this.description,
      this.status,
      this.startingPrice,
      this.venueImagePaths,
      this.maxCapacity,
      this.amenities});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    status = json['status'];
    startingPrice = json['startingPrice'];
    venueImagePaths = json['venueImagePaths'].cast<String>();
    maxCapacity = json['maxCapacity'];
    amenities = json['amenities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    data['status'] = this.status;
    data['startingPrice'] = this.startingPrice;
    data['venueImagePaths'] = this.venueImagePaths;
    data['maxCapacity'] = this.maxCapacity;
    data['amenities'] = this.amenities;
    return data;
  }
}
