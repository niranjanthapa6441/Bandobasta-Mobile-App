class HallBookingRequest {
  String? userId;
  String id;
  String menuId;
  String eventType;

  HallBookingRequest({
    required this.userId,
    required this.menuId,
    required this.id,
    required this.eventType,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['menuId'] = menuId;
    data['eventType'] = eventType;
    return data;
  }
}
