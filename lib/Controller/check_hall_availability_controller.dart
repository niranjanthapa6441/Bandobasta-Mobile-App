import 'package:BandoBasta/Repository/hall_availability_controller.dart';
import 'package:BandoBasta/Response/hall_availability_response.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HallAvailabilityController extends GetxController {
  final HallAvailabilityRepo hallAvailabilityRepo;

  HallAvailabilityController({required this.hallAvailabilityRepo});

  List<dynamic> _hallAvailabilities = [];
  List<dynamic> get hallAvailabilities => _hallAvailabilities;
  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;
  void setVenues() {
    _hallAvailabilities = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> get() async {
    Response response = await hallAvailabilityRepo.getHallAvailabilities();
    if (response.statusCode == 200) {
      HallAvailabilityResponse hallAvailabilityResponse =
          HallAvailabilityResponse.fromJson(response.body);
      if (hallAvailabilityResponse.data != null &&
          hallAvailabilityResponse.data!.hallAvailabilityDetails != null) {
        _hallAvailabilities
            .addAll(hallAvailabilityResponse.data!.hallAvailabilityDetails!);
        _currentPage = hallAvailabilityResponse.data!.currentPage ?? 0;
        _totalElements = hallAvailabilityResponse.data!.totalElements ?? 0;
        _totalPages = hallAvailabilityResponse.data!.totalPages ?? 0;
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
    _isLoaded = false;
    _hallAvailabilities.clear();
    AppConstant.page = 1;
    AppConstant.getVenueURI();
  }
}
