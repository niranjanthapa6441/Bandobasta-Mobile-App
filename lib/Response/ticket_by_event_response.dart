class TicketByEvent {
  String? code;
  String? message;
  Data? data;

  TicketByEvent({this.code, this.message, this.data});

  TicketByEvent.fromJson(Map<String, dynamic> json) {
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
        ticketDTOS!.add(TicketDTOS.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ticketDTOS != null) {
      data['ticketDTOS'] = ticketDTOS!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalElements'] = totalElements;
    data['totalPages'] = totalPages;
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
        ticketDetails!.add(TicketDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['userId'] = userId;
    data['orderDate'] = orderDate;
    data['totalAmount'] = totalAmount;
    data['numberOfTickets'] = numberOfTickets;
    if (ticketDetails != null) {
      data['ticketDetails'] = ticketDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticketOrderId'] = ticketOrderId;
    data['ticketType'] = ticketType;
    data['eventDate'] = eventDate;
    data['orderStatus'] = orderStatus;
    return data;
  }
}
