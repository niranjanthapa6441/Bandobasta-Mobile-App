class HallBookingResponse {
  String? code;
  String? message;
  Data? data;

  HallBookingResponse({this.code, this.message, this.data});

  HallBookingResponse.fromJson(Map<String, dynamic> json) {
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
  List<Bookings>? bookings;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data({this.bookings, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Bookings {
  int? id;
  String? userId;
  String? bookedForDate;
  HallDetail? hallDetail;
  MenuDetail? menuDetail;
  String? requestedDate;
  Null? confirmedDate;
  String? requestedTime;
  Null? confirmedTime;
  double? price;
  String? status;
  String? eventType;

  Bookings(
      {this.id,
      this.userId,
      this.bookedForDate,
      this.hallDetail,
      this.menuDetail,
      this.requestedDate,
      this.confirmedDate,
      this.requestedTime,
      this.confirmedTime,
      this.price,
      this.status,
      this.eventType});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    bookedForDate = json['bookedForDate'];
    hallDetail = json['hallDetail'] != null
        ? new HallDetail.fromJson(json['hallDetail'])
        : null;
    menuDetail = json['menuDetail'] != null
        ? new MenuDetail.fromJson(json['menuDetail'])
        : null;
    requestedDate = json['requestedDate'];
    confirmedDate = json['confirmedDate'];
    requestedTime = json['requestedTime'];
    confirmedTime = json['confirmedTime'];
    price = json['price'];
    status = json['status'];
    eventType = json['eventType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['bookedForDate'] = this.bookedForDate;
    if (this.hallDetail != null) {
      data['hallDetail'] = this.hallDetail!.toJson();
    }
    if (this.menuDetail != null) {
      data['menuDetail'] = this.menuDetail!.toJson();
    }
    data['requestedDate'] = this.requestedDate;
    data['confirmedDate'] = this.confirmedDate;
    data['requestedTime'] = this.requestedTime;
    data['confirmedTime'] = this.confirmedTime;
    data['price'] = this.price;
    data['status'] = this.status;
    data['eventType'] = this.eventType;
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

class MenuDetail {
  String? id;
  String? venueId;
  String? description;
  double? price;
  String? status;
  String? menuType;
  List<FoodDetails>? foodDetails;

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
      foodDetails = <FoodDetails>[];
      json['foodDetails'].forEach((v) {
        foodDetails!.add(new FoodDetails.fromJson(v));
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
