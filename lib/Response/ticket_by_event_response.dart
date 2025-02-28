class TicketByEvent {
  String? code;
  String? message;
  Data? data;

  TicketByEvent({this.code, this.message, this.data});

  TicketByEvent.fromJson(Map<String, dynamic> json) {
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
  List<TicketDTOS>? ticketDTOS;
  int? currentPage;
  int? totalElements;
  int? totalPages;

  Data(
      {this.ticketDTOS, this.currentPage, this.totalElements, this.totalPages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ticketDTOS'] != null) {
      ticketDTOS = <TicketDTOS>[];
      json['ticketDTOS'].forEach((v) {
        ticketDTOS!.add(new TicketDTOS.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ticketDTOS != null) {
      data['ticketDTOS'] = this.ticketDTOS!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class TicketDTOS {
  int? orderId;
  int? userId;
  String? orderDate;
  double? totalAmount;
  int? numberOfTickets;
  List<TicketDetails>? ticketDetails;

  TicketDTOS(
      {this.orderId,
      this.userId,
      this.orderDate,
      this.totalAmount,
      this.numberOfTickets,
      this.ticketDetails});

  TicketDTOS.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userId = json['userId'];
    orderDate = json['orderDate'];
    totalAmount = json['totalAmount'];
    numberOfTickets = json['numberOfTickets'];
    if (json['ticketDetails'] != null) {
      ticketDetails = <TicketDetails>[];
      json['ticketDetails'].forEach((v) {
        ticketDetails!.add(new TicketDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['orderDate'] = this.orderDate;
    data['totalAmount'] = this.totalAmount;
    data['numberOfTickets'] = this.numberOfTickets;
    if (this.ticketDetails != null) {
      data['ticketDetails'] =
          this.ticketDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketDetails {
  int? ticketOrderId;
  String? ticketType;
  String? eventDate;
  String? orderStatus;

  TicketDetails(
      {this.ticketOrderId, this.ticketType, this.eventDate, this.orderStatus});

  TicketDetails.fromJson(Map<String, dynamic> json) {
    ticketOrderId = json['ticketOrderId'];
    ticketType = json['ticketType'];
    eventDate = json['eventDate'];
    orderStatus = json['orderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketOrderId'] = this.ticketOrderId;
    data['ticketType'] = this.ticketType;
    data['eventDate'] = this.eventDate;
    data['orderStatus'] = this.orderStatus;
    return data;
  }
}
