class HallBookingRequest {
  String userId;
  String hallAvailabilityId;
  String menuId;
  String eventType;

  HallBookingRequest(
      {required this.userId,
      required this.menuId,
      required this.hallAvailabilityId,
      required this.eventType,});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['hallAvailabilityId'] = hallAvailabilityId;
    data['menuId'] = menuId;
    data['eventType'] = eventType;
    return data;
  }
}
