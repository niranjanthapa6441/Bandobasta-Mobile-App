import 'package:get/get.dart';
import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class EventRepository extends GetxService {
  final APIClient apiClient;
  EventRepository({required this.apiClient});

  Future<Response> getTicketByEvent(int page, int size) async {
    return await apiClient.getData(AppConstant.getAllTicketsByEventURI(page,size));
  }

  Future<Response> checkIn(String ticketOrderId) async {
    return await apiClient.postData(AppConstant.checkIn(ticketOrderId), {});
  }

  Future<Response> getCountOfCheckedInAndBookedTicketsByEvent() async {
    return await apiClient.getData(AppConstant.getCountOfCheckedInAndBookedTicketsByEventURI());
  }
}
