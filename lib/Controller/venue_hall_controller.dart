import 'package:BandoBasta/Repository/venue_hall_repo.dart';
import 'package:BandoBasta/Response/venue_hall_response.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VenueHallController extends GetxController {
  final VenueHallRepo venueHallRepo;

  VenueHallController({required this.venueHallRepo});

  List<HallDetail> _venueHalls = [];
  List<HallDetail> get venueHalls => _venueHalls;

  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;

  void setVenues() {
    _venueHalls = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await venueHallRepo.getVenueHalls();
    if (response.statusCode == 200) {
      VenueHallResponse venueHallResponse =
          VenueHallResponse.fromJson(response.body);
      if (venueHallResponse.data != null &&
          venueHallResponse.data!.hallDetails != null) {
        _venueHalls.addAll(venueHallResponse.data!.hallDetails!);
        _currentPage = venueHallResponse.data!.currentPage ?? 0;
        _totalElements = venueHallResponse.data!.totalElements ?? 0;
        _totalPages = venueHallResponse.data!.totalPages ?? 0;
      }

      _isLoaded = true;
      update();
    } else {
      _isLoaded = false;
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
    _venueHalls.clear();
    AppConstant.page = 1;
    AppConstant.getVenueURI();
  }
}
