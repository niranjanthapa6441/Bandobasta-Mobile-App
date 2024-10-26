import 'package:BandoBasta/Repository/venue_repo.dart';
import 'package:BandoBasta/Response/venue_response.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VenueController extends GetxController {
  final VenueRepo venueRepo;

  VenueController({required this.venueRepo});

  List<dynamic> _venues = [];
  List<dynamic> get venues => _venues;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;

  void setCustomerBookingDetail() {
    _venues = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> get() async {
    Response response = await venueRepo.getVenues();
    if (response.statusCode == 200) {
      print("length of tyhe data from response" +
          VenueResponse.fromJson(response.body)
              .data!
              .venues!
              .length
              .toString());
      _venues.addAll(VenueResponse.fromJson(response.body).data!.venues!);
      _currentPage = VenueResponse.fromJson(response.body).data!.currentPage!;
      _totalElements =
          VenueResponse.fromJson(response.body).data!.totalElements!;
      _totalPages = VenueResponse.fromJson(response.body).data!.totalPages!;
      _isLoaded = true;
      print("Venues length befire ckear" + _venues.length.toString());
      update();
    }
  }

  Future<void> loadMore() async {
    if (_currentPage < _totalPages) {
      AppConstant.page += 1;
      AppConstant.getVenueURI();
      get();
    }
  }

  @override
  void onClose() {
    clear();
    super.onClose();
  }

  void clear() {
    _venues.clear();
    print("Venues lentgh after ckear" + _venues.length.toString());
    AppConstant.page = 1;
    AppConstant.getVenueURI();
  }
}
