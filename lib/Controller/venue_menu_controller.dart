import 'package:bandobasta/Repository/venue_menu_repository.dart';
import 'package:bandobasta/Response/venue_menu_response.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VenueMenuController extends GetxController {
  final VenueMenuRepo venueMenuRepo;

  VenueMenuController({required this.venueMenuRepo});
  Map<String, List<Map<String, dynamic>>> _categorizedMenuMap = {};
  Map<String, List<Map<String, dynamic>>> get categorizedMenuMap =>
      _categorizedMenuMap;

  Map<String, Map<String, int>> _menuCategoryCounts = {};
  Map<String, Map<String, int>> get menuCategoryCount => _menuCategoryCounts;
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
      VenueMenuReponse venueMenuReponse =
          VenueMenuReponse.fromJson(response.body);
      if (venueMenuReponse.data != null &&
          venueMenuReponse.data!.menuDetails != null) {
        _venueMenus.addAll(venueMenuReponse.data!.menuDetails!);
        countFoodItemsByCategoryPerMenu(venueMenuReponse.data!.menuDetails!);
        getCategorizedMenu(venueMenuReponse.data!.menuDetails!);
        _currentPage = venueMenuReponse.data!.currentPage ?? 0;
        _totalElements = venueMenuReponse.data!.totalElements ?? 0;
        _totalPages = venueMenuReponse.data!.totalPages ?? 0;
      }

      _isLoaded = true;
      update();
    } else {
      _isLoaded = false;
      update();
    }
  }

  Map<String, Map<String, int>> countFoodItemsByCategoryPerMenu(
      List<MenuDetail> menuDetails) {
    for (var menu in menuDetails) {
      Map<String, int> foodCategoryCounts = {};

      for (var food in menu.foodDetails!) {
        if (foodCategoryCounts.containsKey(food.foodCategory)) {
          foodCategoryCounts[food.foodCategory!] =
              foodCategoryCounts[food.foodCategory]! + 1;
        } else {
          foodCategoryCounts[food.foodCategory!] = 1;
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

  Map<String, String> categoryMapping = {
    'SALAD': 'Salad',
    'MAIN_COURSE_NON_VEGETARIAN': 'Main Course - Non-Vegetarian',
    'MAIN_COURSE_VEGETARIAN': 'Main Course - Vegetarian',
    'DESSERT': 'Dessert',
    'BREAD': 'Bread',
    'RICE': 'Rice',
    'SOUP': 'Soup',
    'DAL': 'Dal',
    'STARTERS': 'Starters',
    'BEVERAGE_NON_ALCOHOLIC': 'Beverages',
  };

  List<Map<String, dynamic>> getCategorizedMenu(List<MenuDetail> menuDetails) {
    List<Map<String, dynamic>> categorizedMenus = [];

    for (var menu in menuDetails) {
      Map<String, List<Map<String, dynamic>>> menuMap = {};

      for (var food in menu.foodDetails!) {
        String category = food.foodCategory!;
        String categoryName = categoryMapping[category] ?? category;

        if (!menuMap.containsKey(categoryName)) {
          menuMap[categoryName] = [];
        }

        menuMap[categoryName]!.add({
          'name': food.name!,
        });
      }

      categorizedMenus.add({
        'menuId': menu.id,
        'categories': menuMap.entries.map((entry) {
          return {
            'category': entry.key,
            'items': entry.value,
          };
        }).toList(),
      });
    }
    return categorizedMenus;
  }
}
