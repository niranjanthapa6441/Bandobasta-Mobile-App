import 'package:bandobasta/Model/response_model.dart';
import 'package:bandobasta/Repository/booking_repository.dart';
import 'package:bandobasta/Request/hall_booking_request.dart';
import 'package:bandobasta/Response/hall_booking_response.dart';
import 'package:get/get.dart';

import '../utils/app_constants/app_constant.dart';

class BookingController extends GetxController {
  final BookingRepository bookingRepository;

  BookingController({required this.bookingRepository});

  List<dynamic> _customerOrderDetails = [];
  List<dynamic> get customerOrderDetails => _customerOrderDetails;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setCustomerBookingDetail() {
    _customerOrderDetails = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await bookingRepository.getCustomerHallBookingDetails();

    if (response.statusCode == 200) {
      HallBookingResponse bookingResponse =
          HallBookingResponse.fromJson(response.body);

      if (bookingResponse.data != null &&
          bookingResponse.data!.bookings != null) {
        _customerOrderDetails.addAll(bookingResponse.data!.bookings!);
        _currentPage = bookingResponse.data!.currentPage ?? 0;
        _totalElements = bookingResponse.data!.totalElements ?? 0;
        _totalPages = bookingResponse.data!.totalPages ?? 0;
      }
      _isLoaded = true;
      update();
    } else {
      Response response =
          await bookingRepository.getCustomerHallBookingDetails();
      // ErrorResponse error = ErrorResponse.fromJson(response.body);
      // showCustomSnackBar(error.message, title: "orders");
    }
  }

  Future<ResponseModel> saveHallBooking(HallBookingRequest request) async {
    Response response = await bookingRepository.saveHallBooking(request);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
      print("I'm here");
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      AppConstant.page += 1;
      AppConstant.getHallBookingURI();
      get();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _customerOrderDetails.clear();
    AppConstant.page = 1;
    AppConstant.getHallBookingURI();
  }
}
