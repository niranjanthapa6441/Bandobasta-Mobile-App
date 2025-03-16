import 'package:BandoBasta/Model/response_model.dart';
import 'package:BandoBasta/Repository/event_repository.dart';
import 'package:BandoBasta/Response/count_checked_in_booked_response.dart';
import 'package:BandoBasta/Response/ticket_by_event_response.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final EventRepository eventRepository;

  EventController({required this.eventRepository});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  final List<TicketDTOS> _allTicketByEvent = [];
  List<TicketDTOS> get allTicketByEvent => _allTicketByEvent;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;
  int _page = 1;
  final int _size = 10;
  int _totalBooked = 0;
  int _totalCheckedIn = 0;
  int get totalBooked => _totalBooked;
  int get totalCheckedIn => _totalCheckedIn;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;

  Future<ResponseModel> checkIn(String ticketOrderId) async {
    Response response = await eventRepository.checkIn(ticketOrderId);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<void> getAllTicketByEvent() async {
    Response response = await eventRepository.getTicketByEvent(_page, _size);

    if (response.statusCode == 200) {
      TicketByEvent ticketByEventResponse =
          TicketByEvent.fromJson(response.body);
      if (ticketByEventResponse.data != null &&
          ticketByEventResponse.data!.ticketDTOS != null) {
        _allTicketByEvent.addAll(ticketByEventResponse.data!.ticketDTOS!);
        _currentPage = ticketByEventResponse.data!.currentPage ?? 0;
        _totalElements = ticketByEventResponse.data!.totalElements ?? 0;
        _totalPages = ticketByEventResponse.data!.totalPages ?? 0;
      }
      print(_allTicketByEvent);
      _isLoaded = true;
      update();
    } else {}
  }

  Future<void> getCountOfCheckedInAndBookedTicketsByEvent() async {
    Response response =
        await eventRepository.getCountOfCheckedInAndBookedTicketsByEvent();
    if (response.statusCode == 200) {
      CountOfBookedAndCheckInTicketResponse countResponse =
          CountOfBookedAndCheckInTicketResponse.fromJson(response.body);

      print(countResponse);
      if (countResponse.data != null) {
        _totalBooked = countResponse.data!.totalBooked!;
        _totalCheckedIn = countResponse.data!.totalCheckedIn!;
        print(totalBooked);
      }
    } else {}
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      _page += 1;
      AppConstant.getAllTicketsByEventURI(_page, _size);
      getAllTicketByEvent();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  Future<void> clear() async {
    _isLoaded = false;
    _allTicketByEvent.clear();
    _page = 1;
    AppConstant.getAllTicketsByEventURI(_page, _size);
  }
}
