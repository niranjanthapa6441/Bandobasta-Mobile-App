import 'package:BandoBasta/Request/hall_booking_request.dart';
import 'package:BandoBasta/utils/api/api_client.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:get/get.dart';

class BookingRepository extends GetxService {
  final APIClient apiClient;
  BookingRepository({required this.apiClient});

  Future<Response> getCustomerHallBookingDetails() async {
    AuthService authService = AuthService();
    return await apiClient.getData(
        AppConstant.getHallBookingURI(await authService.getUserId()));
  }

  Future<Response> saveHallBooking(HallBookingRequest request) async {
    return await apiClient.postData(
        AppConstant.getSaveHallBookingURL(), request.toJson());
  }
}
