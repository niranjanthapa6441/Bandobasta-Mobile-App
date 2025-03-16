import 'package:BandoBasta/Response/venue_menu_response.dart';

class VenuePackageResponse {
  String? code;
  String? message;
  Data? data;

  VenuePackageResponse({this.code, this.message, this.data});

  VenuePackageResponse.fromJson(Map<String, dynamic> json) {
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
  List<Package>? packages;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data({this.packages, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Package>[];
      json['packages'].forEach((v) {
        packages!.add(Package.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
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
        ? HallDetail.fromJson(json['hallDetail'])
        : null;
    menuDetail = json['menuDetail'] != null
        ? MenuDetail.fromJson(json['menuDetail'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['venueId'] = venueId;
    data['name'] = name;
    data['packageType'] = packageType;
    data['eventType'] = eventType;
    data['description'] = description;
    data['price'] = price;
    data['amenities'] = amenities;
    if (hallDetail != null) {
      data['hallDetail'] = hallDetail!.toJson();
    }
    if (menuDetail != null) {
      data['menuDetail'] = menuDetail!.toJson();
    }
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['venueId'] = venueId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['foodCategory'] = foodCategory;
    return data;
  }
}
