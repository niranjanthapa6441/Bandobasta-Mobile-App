class VenueMenuResponse {
  String? code;
  String? message;
  Data? data;

  VenueMenuResponse({this.code, this.message, this.data});

  VenueMenuResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
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
    menuDetails = (json['menuDetails'] as List?)
        ?.map((v) => MenuDetail.fromJson(v))
        .toList();
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    return {
      'menuDetails': menuDetails?.map((v) => v.toJson()).toList(),
      'currentPage': currentPage,
      'totalElements': totalElements,
      'totalPages': totalPages,
    };
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
  List<MenuItemSelectionRangeDetail>? menuItemSelectionRangeDetails;

  MenuDetail({
    this.id,
    this.venueId,
    this.description,
    this.price,
    this.status,
    this.menuType,
    this. foodDetails,
    this.menuItemSelectionRangeDetails,
  });

  MenuDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venueId'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    menuType = json['menuType'];
    foodDetails = (json['foodDetails'] as List?)
        ?.map((v) => FoodDetail.fromJson(v))
        .toList();
    menuItemSelectionRangeDetails =
        (json['menuItemSelectionRangeDetails'] as List?)
            ?.map((v) => MenuItemSelectionRangeDetail.fromJson(v))
            .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'description': description,
      'price': price,
      'status': status,
      'menuType': menuType,
      'foodDetails': foodDetails?.map((v) => v.toJson()).toList(),
      'menuItemSelectionRangeDetails':
          menuItemSelectionRangeDetails?.map((v) => v.toJson()).toList(),
    };
  }
}

class FoodDetail {
  String? id;
  String? venueId;
  String? name;
  String? description;
  String? imageUrl; // Changed to String? for better null safety
  String? status;
  String? foodCategory;
  String? foodSubCategory;

  FoodDetail({
    this.id,
    this.venueId,
    this.name,
    this.description,
    this.imageUrl,
    this.status,
    this.foodCategory,
    this.foodSubCategory,
  });

  FoodDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueId = json['venueId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    status = json['status'];
    foodCategory = json['foodCategory'];
    foodSubCategory = json['foodSubCategory'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venueId': venueId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'status': status,
      'foodCategory': foodCategory,
      'foodSubCategory': foodSubCategory,
    };
  }
}

class MenuItemSelectionRangeDetail {
  int? maxSelection;
  String? foodSubCategory;

  MenuItemSelectionRangeDetail({this.maxSelection, this.foodSubCategory});

  MenuItemSelectionRangeDetail.fromJson(Map<String, dynamic> json) {
    maxSelection = json['maxSelection'];
    foodSubCategory = json['foodSubCategory'];
  }

  Map<String, dynamic> toJson() {
    return {
      'maxSelection': maxSelection,
      'foodSubCategory': foodSubCategory,
    };
  }
}
