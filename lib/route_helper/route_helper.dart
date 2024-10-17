import 'package:bandobasta/Pages/VenueInfoPage/venue_info_page.dart';
import 'package:bandobasta/Pages/homepage/homepage.dart';
import 'package:bandobasta/Pages/homepage/navigation.dart';
import 'package:bandobasta/Pages/menuPage/food_menu_page.dart';
import 'package:bandobasta/Pages/menuPage/venu_menu_page.dart';
import 'package:bandobasta/Pages/searchVenuePage/search_venue_page.dart';
import 'package:bandobasta/Pages/venueHallPage/hall_info.dart';
import 'package:bandobasta/Pages/venueHallPage/venue_halls.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/signIn';
  static const String navigation = '/navigation';
  static const String signUp = '/signUp';
  static const String homepage = '/homepage';
  static const String searchVenue = '/searchVenue';
  static const String bookings = '/bookings';
  static const String venueInfo = '/viewVenueInfo';
  static const String viewProfile = '/viewProfile';
  static const String viewNotifications = '/viewNotifications';
  static const String venueMenus = '/venueMenus';
  static const String menuDetail = '/menudetail';
  static const String venueHalls = '/venueHalls';
  static const String venueHallInfo = '/venueHallInfo';
  static const String bookingDetail = '/orderDetail';
  static const String cart = '/cart';
  static const String confirmBooking = '/confirmBooking';
  static const String venueMenuFood = '/venue/menu/food';

  static String getInitial() => initial;
  static String getNavigation() => navigation;
  static String getSignIn() => signIn;
  static String getSignUp() => signUp;
  static String getVenueInfo(int pageId) => '$venueInfo?pageId=$pageId';
  static String getHallInfo(int pageId) => '$venueHallInfo?pageId=$pageId';
  static String getMenuDetail(String menuId, String menuName, String price) =>
      '$menuDetail?menuId=$menuId&menuName=$menuName&price=$price';
  static String getHomepage() => homepage;
  static String getSearchVenue() => searchVenue;
  static String getOrders() => bookings;
  static String getViewProfile() => viewProfile;
  static String getViewNotiifcations() => viewNotifications;
  static String getVenueHalls(String venueName) =>
      '$venueHalls?venueName=$venueName';
  static String getVenueMenus(String venueName, String imageURL) =>
      '$venueMenus?venueName=$venueName&imageURL=$imageURL';
  static String getOrderDetail(int bookingId) =>
      '$bookingDetail?bookingId=$bookingId';
  static String getConfirmOrder() => confirmBooking;
  static String getRestaurantMenuFoodDetail(int foodId) =>
      '$venueMenuFood?foodId=$foodId';
  static String getCart() => cart;

  static List<GetPage> routes = [
    GetPage(name: homepage, page: () => const Homepage()),
    GetPage(
      name: navigation,
      page: () => const Navigation(),
      transition: Transition.noTransition,
    ),
    GetPage(name: searchVenue, page: () => SearchVenuePage()),
    GetPage(
        name: venueMenus,
        page: () {
          var name = Get.parameters['venueName'];
          var imageURL = Get.parameters['imageURL'];
          return VenueMenuPage(venueName: name!, imageURL: imageURL!);
        }),
    GetPage(
        name: venueHalls,
        page: () {
          var name = Get.parameters['venueName'];
          return VenueHallPage(venueName: name!);
        }),
    GetPage(
        name: venueInfo,
        page: () {
          var pageId = Get.parameters['pageId'];
          return VenueInfoPage(
            pageId: int.parse(pageId!),
          );
        }),
    GetPage(
        name: venueHallInfo,
        page: () {
          var pageId = Get.parameters['pageId'];
          return HallInfoPage(
            pageId: int.parse(pageId!),
          );
        }),
    GetPage(
        name: menuDetail,
        page: () {
          var menuId = Get.parameters['menuId'];
          var menuName = Get.parameters['menuName'];
          var price = Get.parameters['price'];
          return FoodMenuScreen(
              targetMenuId: menuId!, menuName: menuName!, price: price!);
        }),
    // GetPage(name: viewProfile, page: () => const ProfilePage()),
    // GetPage(name: updateProfile, page: () => const UpdateProfilePage()),

    // GetPage(name: payments, page: () => const PaymentDetailsPage()),
    // GetPage(name: cart, page: () => const CartPage()),
    // GetPage(name: restaurantMenu, page: () => const RestaurantMenu()),
    // GetPage(
    //     name: orderDetail,
    //     page: () {
    //       var orderId = Get.parameters['orderId'];
    //       return OrderPage(
    //         orderId: int.parse(orderId!),
    //       );
    //     }),
    // GetPage(
    //     name: foodDetail,
    //     page: () {
    //       var foodId = Get.parameters['foodId'];
    //       return FoodPage(
    //         foodId: int.parse(foodId!),
    //       );
    //     }),
    // GetPage(
    //     name: restaurantMenuFood,
    //     page: () {
    //       var foodId = Get.parameters['foodId'];
    //       return RestaurantMenuFoodPage(
    //         foodId: int.parse(foodId!),
    //       );
    // }),
  ];
}
