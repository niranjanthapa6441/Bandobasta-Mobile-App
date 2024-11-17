import 'package:BandoBasta/Repository/venue_menu_repository.dart';
import 'package:BandoBasta/Response/venue_menu_response.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VenueMenuController extends GetxController {
  final VenueMenuRepo venueMenuRepo;

  VenueMenuController({required this.venueMenuRepo});
  Map<String, List<Map<String, dynamic>>> _categorizedMenuMap = {};
  Map<String, List<Map<String, dynamic>>> get categorizedMenuMap =>
      _categorizedMenuMap;

  Map<String, Map<String, Map<String, dynamic>>> _menuCategoryCounts = {};
  Map<String, Map<String, Map<String, dynamic>>> get menuCategoryCount =>
      _menuCategoryCounts;
  List<MenuDetail> _venueMenus = [];
  List<MenuDetail> get venueMenus => _venueMenus;

  int _currentPage = 0;
  int _totalPages = 0;
  int _totalElements = 0;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  int get totalElements => _totalElements;

  void setVenues() {
    _venueMenus = [];
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> get() async {
    Response response = await venueMenuRepo.getVenueMenus();
    if (response.statusCode == 200) {
      VenueMenuResponse venueMenuResponse =
          VenueMenuResponse.fromJson(response.body);
      if (venueMenuResponse.data != null &&
          venueMenuResponse.data!.menuDetails != null) {
        _venueMenus.addAll(venueMenuResponse.data!.menuDetails!);
        countFoodItemsByCategoryAndSubcategory(
            venueMenuResponse.data!.menuDetails!);
        _currentPage = venueMenuResponse.data!.currentPage ?? 0;
        _totalElements = venueMenuResponse.data!.totalElements ?? 0;
        _totalPages = venueMenuResponse.data!.totalPages ?? 0;
      }

      _isLoaded = true;
      update();
    } else {
      _isLoaded = false;
      update();
    }
  }

  Map<String, Map<String, Map<String, dynamic>>>
      countFoodItemsByCategoryAndSubcategory(List<MenuDetail> menuDetails) {
    for (var menu in menuDetails) {
      Map<String, Map<String, dynamic>> foodCategoryCounts = {};
      if (menu.foodDetails != null) {
        for (var food in menu.foodDetails!) {
          String category = food.foodCategory ?? 'Unknown Category';
          String subCategory = food.foodSubCategory ?? 'Unknown Subcategory';

          if (!foodCategoryCounts.containsKey(category)) {
            foodCategoryCounts[category] = {'total': 0, 'subcategories': {}};
          }

          if (foodCategoryCounts[category]!['subcategories']
              .containsKey(subCategory)) {
            foodCategoryCounts[category]!['subcategories'][subCategory] =
                foodCategoryCounts[category]!['subcategories'][subCategory]! +
                    1;
          } else {
            foodCategoryCounts[category]!['subcategories'][subCategory] = 1;
          }

          foodCategoryCounts[category]!['total'] =
              foodCategoryCounts[category]!['total']! + 1;
        }
      }

      _menuCategoryCounts[menu.id!] = foodCategoryCounts;
    }

    return _menuCategoryCounts;
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
    _venueMenus.clear();
    _menuCategoryCounts.clear();
    _categorizedMenuMap.clear();
    AppConstant.page = 1;
    AppConstant.getVenueURI();
  }
}
