import 'package:bandobasta/Repository/venue_package_repo.dart';
import 'package:bandobasta/Response/venu_package_response.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VenuePackageController extends GetxController {
  final VenuePackageRepo venuePackageRepo;

  VenuePackageController({required this.venuePackageRepo});

  List<Package> _venuePackages = [];
  List<Package> get venuePackages => _venuePackages;

  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;

  void setVenues() {
    _venuePackages = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await venuePackageRepo.getVenuePackages();
    if (response.statusCode == 200) {
      VenuePackageResponse venuePackageResponse =
          VenuePackageResponse.fromJson(response.body);
      if (venuePackageResponse.data != null &&
          venuePackageResponse.data!.packages != null) {
        _venuePackages.addAll(venuePackageResponse.data!.packages!);
        _currentPage = venuePackageResponse.data!.currentPage ?? 0;
        _totalElements = venuePackageResponse.data!.totalElements ?? 0;
        _totalPages = venuePackageResponse.data!.totalPages ?? 0;
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
    _venuePackages.clear();
    AppConstant.page = 1;
    AppConstant.getVenueURI();
  }
}
