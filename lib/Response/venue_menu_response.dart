class VenueMenuReponse {
  String? code;
  String? message;
  Data? data;

  VenueMenuReponse({this.code, this.message, this.data});

  VenueMenuReponse.fromJson(Map<String, dynamic> json) {
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
  List<MenuDetail>? menuDetails;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data(
      {this.menuDetails,
      this.currentPage,
      this.totalElements,
      this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['menuDetails'] != null) {
      menuDetails = <MenuDetail>[];
      json['menuDetails'].forEach((v) {
        menuDetails!.add(new MenuDetail.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menuDetails != null) {
      data['menuDetails'] = this.menuDetails!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class MenuDetail {
  String? id;
  String? venueId;
  String? description;
  double? price;
  String? status;
  String? menuType;
  List<FoodDetail>? foodDetails;

  MenuDetail(
      {this.id,
      this.venueId,
      this.description,
      this.price,
      this.status,
      this.menuType,
      this.foodDetails});

  MenuDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venueId'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    menuType = json['menuType'];
    if (json['foodDetails'] != null) {
      foodDetails = <FoodDetail>[];
      json['foodDetails'].forEach((v) {
        foodDetails!.add(new FoodDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['venueId'] = this.venueId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['status'] = this.status;
    data['menuType'] = this.menuType;
    if (this.foodDetails != null) {
      data['foodDetails'] = this.foodDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodDetail {
  String? id;
  String? venueId;
  String? name;
  String? description;
  String? imageUrl;
  String? status;
  String? foodCategory;

  FoodDetail(
      {this.id,
      this.venueId,
      this.name,
      this.description,
      this.imageUrl,
      this.status,
      this.foodCategory});

  FoodDetail.fromJson(Map<String, dynamic> json) {
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
