import 'package:BandoBasta/Request/hall_booking_request.dart';
import 'package:BandoBasta/utils/api/api_client.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get.dart';

class BookingRepository extends GetxService {
  final APIClient apiClient;
  BookingRepository({required this.apiClient});

  Future<Response> getCustomerHallBookingDetails() async {
    return await apiClient.getData(
        AppConstant.getHallBookingURI(), apiClient.mainHeaders);
  }

  Future<Response> saveHallBooking(HallBookingRequest request) async {
    return await apiClient.postData(
        AppConstant.getSaveHallBookingURL(), request.toJson());
  }
}
