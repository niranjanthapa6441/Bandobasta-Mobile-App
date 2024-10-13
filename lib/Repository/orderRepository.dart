import 'package:bandobasta/utils/api/api_client.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:get/get.dart';

class BookingRepository extends GetxService {
  final APIClient apiClient;
  BookingRepository({required this.apiClient});

  Future<Response> getCustomerHallOrderDetails() async {
    return await apiClient.getData(
        AppConstant.getHallBookingURI(), apiClient.mainHeaders);
  }

  // Future<Response> orderFoods(BookingRequest request) async {
  //   return await apiClient.postData(AppConstant.saveOrderURI, request.toJson());
  // }
}