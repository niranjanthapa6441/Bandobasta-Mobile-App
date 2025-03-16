class VenueResponse {
  String? code;
  String? message;
  Data? data;

  VenueResponse({this.code, this.message, this.data});

  VenueResponse.fromJson(Map<String, dynamic> json) {
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
  List<Venue>? venues;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data({this.venues, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['venues'] != null) {
      venues = <Venue>[];
      json['venues'].forEach((v) {
        venues!.add(Venue.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (venues != null) {
      data['venues'] = venues!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    data['status'] = status;
    data['startingPrice'] = startingPrice;
    data['venueImagePaths'] = venueImagePaths;
    data['maxCapacity'] = maxCapacity;
    data['amenities'] = amenities;
    return data;
  }
}
