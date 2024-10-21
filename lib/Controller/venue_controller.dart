import 'package:bandobasta/Repository/venue_repo.dart';
import 'package:bandobasta/Response/venue_response.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
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
  void setVenues() {
    _venues = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await venueRepo.getVenues();
    if (response.statusCode == 200) {
      VenueResponse venueResponse = VenueResponse.fromJson(response.body);
      if (venueResponse.data != null && venueResponse.data!.venues != null) {
        _venues.addAll(venueResponse.data!.venues!);  
        _currentPage = venueResponse.data!.currentPage ?? 0;
        _totalElements = venueResponse.data!.totalElements ?? 0;
        _totalPages = venueResponse.data!.totalPages ?? 0;
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
    _venues.clear();
    AppConstant.page = 1;
    AppConstant.getVenueURI();
  }
}
