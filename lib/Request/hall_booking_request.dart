class HallBookingRequest {
  String? userId;
  String id;
  String menuId;
  String eventType;
  int numberOfGuests;
  List<String> foodIds;

  HallBookingRequest(
      {required this.userId,
      required this.menuId,
      required this.id,
      required this.eventType,
      required this.numberOfGuests,
      required this.foodIds});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['menuId'] = menuId;
    data['eventType'] = eventType;
    data['foodIds'] = foodIds;
    data['numberOfGuests'] = numberOfGuests;
    return data;
  }
}
