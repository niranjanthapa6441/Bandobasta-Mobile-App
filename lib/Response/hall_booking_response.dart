class HallBookingResponse {
  String? code;
  String? message;
  Data? data;

  HallBookingResponse({this.code, this.message, this.data});

  HallBookingResponse.fromJson(Map<String, dynamic> json) {
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
  List<Booking>? bookings;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data({this.bookings, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['bookings'] != null) {
      bookings = <Booking>[];
      json['bookings'].forEach((v) {
        bookings!.add(Booking.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
    return data;
  }
}

class Booking {
  int? id;
  String? venueName;
  String? userId;
  String? bookedForDate;
  HallDetail? hallDetail;
  MenuDetail? menuDetail;
  String? requestedDate;
  String? confirmedDate;
  String? requestedTime;
  String? confirmedTime;
  double? price;
  String? status;
  String? eventType;
  String? startTime;
  String? endTime;
  int? numberOfGuests;

  Booking(
      {this.id,
      this.venueName,
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
      this.eventType,
      this.startTime,
      this.numberOfGuests,
      this.endTime});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    venueName = json['venueName'];
    userId = json['userId'];
    bookedForDate = json['bookedForDate'];
    hallDetail = json['hallDetail'] != null
        ? HallDetail.fromJson(json['hallDetail'])
        : null;
    menuDetail = json['menuDetail'] != null
        ? MenuDetail.fromJson(json['menuDetail'])
        : null;
    requestedDate = json['requestedDate'];
    confirmedDate = json['confirmedDate'];
    requestedTime = json['requestedTime'];
    confirmedTime = json['confirmedTime'];
    price = json['price'];
    status = json['status'];
    eventType = json['eventType'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    numberOfGuests = json['numberOfGuests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['venueName'] = venueName;
    data['userId'] = userId;
    data['bookedForDate'] = bookedForDate;
    if (hallDetail != null) {
      data['hallDetail'] = hallDetail!.toJson();
    }
    if (menuDetail != null) {
      data['menuDetail'] = menuDetail!.toJson();
    }
    data['requestedDate'] = requestedDate;
    data['confirmedDate'] = confirmedDate;
    data['requestedTime'] = requestedTime;
    data['confirmedTime'] = confirmedTime;
    data['price'] = price;
    data['status'] = status;
    data['eventType'] = eventType;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
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

class MenuDetail {
  String? id;
  String? venueId;
  String? description;
  double? price;
  String? status;
  String? menuType;
  List<FoodDetails>? foodDetails;
  Null menuItemSelectionRangeDetails;

  MenuDetail(
      {this.id,
      this.venueId,
      this.description,
      this.price,
      this.status,
      this.menuType,
      this.foodDetails,
      this.menuItemSelectionRangeDetails});

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
        foodDetails!.add(FoodDetails.fromJson(v));
      });
    }
    menuItemSelectionRangeDetails = json['menuItemSelectionRangeDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['venueId'] = venueId;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['menuType'] = menuType;
    if (foodDetails != null) {
      data['foodDetails'] = foodDetails!.map((v) => v.toJson()).toList();
    }
    data['menuItemSelectionRangeDetails'] = menuItemSelectionRangeDetails;
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
  String? foodSubCategory;

  FoodDetails(
      {this.id,
      this.venueId,
      this.name,
      this.description,
      this.imageUrl,
      this.status,
      this.foodCategory,
      this.foodSubCategory});

  FoodDetails.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['venueId'] = venueId;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    data['foodCategory'] = foodCategory;
    data['foodSubCategory'] = foodSubCategory;
    return data;
  }
}
