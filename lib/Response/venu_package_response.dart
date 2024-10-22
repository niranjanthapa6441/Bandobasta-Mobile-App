import 'package:BandoBasta/Response/venue_menu_response.dart';

class VenuePackageResponse {
  String? code;
  String? message;
  Data? data;

  VenuePackageResponse({this.code, this.message, this.data});

  VenuePackageResponse.fromJson(Map<String, dynamic> json) {
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
  List<Package>? packages;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data({this.packages, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Package>[];
      json['packages'].forEach((v) {
        packages!.add(new Package.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Package {
  String? id;
  String? venueId;
  String? name;
  String? packageType;
  String? eventType;
  String? description;
  double? price;
  List<String>? amenities;
  HallDetail? hallDetail;
  MenuDetail? menuDetail;
  String? status;

  Package(
      {this.id,
      this.venueId,
      this.name,
      this.packageType,
      this.eventType,
      this.description,
      this.price,
      this.amenities,
      this.hallDetail,
      this.menuDetail,
      this.status});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venueId'];
    name = json['name'];
    packageType = json['packageType'];
    eventType = json['eventType'];
    description = json['description'];
    price = json['price'];
    amenities = json['amenities'].cast<String>();
    hallDetail = json['hallDetail'] != null
        ? new HallDetail.fromJson(json['hallDetail'])
        : null;
    menuDetail = json['menuDetail'] != null
        ? new MenuDetail.fromJson(json['menuDetail'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['venueId'] = this.venueId;
    data['name'] = this.name;
    data['packageType'] = this.packageType;
    data['eventType'] = this.eventType;
    data['description'] = this.description;
    data['price'] = this.price;
    data['amenities'] = this.amenities;
    if (this.hallDetail != null) {
      data['hallDetail'] = this.hallDetail!.toJson();
    }
    if (this.menuDetail != null) {
      data['menuDetail'] = this.menuDetail!.toJson();
    }
    data['status'] = this.status;
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

class FoodDetails {
  String? id;
  String? venueId;
  String? name;
  String? description;
  String? imageUrl;
  String? status;
  String? foodCategory;

  FoodDetails(
      {this.id,
      this.venueId,
      this.name,
      this.description,
      this.imageUrl,
      this.status,
      this.foodCategory});

  FoodDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venueId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    foodCategory = json['foodCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['venueId'] = this.venueId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['status'] = this.status;
    data['foodCategory'] = this.foodCategory;
    return data;
  }
}
