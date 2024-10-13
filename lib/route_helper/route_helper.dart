import 'package:bandobasta/Pages/homepage/homepage.dart';
import 'package:bandobasta/Pages/homepage/navigation.dart';
import 'package:bandobasta/Pages/searchVenuePage/searchVenuePage.dart';
import 'package:get/get.dart';


class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/signIn';
  static const String navigation = '/navigation';
  static const String signUp = '/signUp';
  static const String homepage = '/homepage';
  static const String searchVenue = '/searchVenue';
  static const String bookings = '/bookings';
  static const String viewProfile = '/viewProfile';
  static const String viewNotifications = '/viewNotifications';
  static const String menuDetail = '/menuDetail';
  static const String payments = '/payments';
  static const String restaurantMenu = '/menu';
  static const String bookingDetail = '/orderDetail';
  static const String cart = '/cart';
  static const String confirmBooking = '/confirmBooking';
  static const String venueMenuFood = '/venue/menu/food';

  static String getInitial() => initial;
  static String getNavigation() => navigation;
  static String getSignIn() => signIn;
  static String getSignUp() => signUp;
  static String getHomepage() => homepage;
  static String getSearchVenue() => searchVenue;
  static String getOrders() => bookings;
  static String getViewProfile() => viewProfile;
  static String getViewNotiifcations() => viewNotifications;
  static String getRestaurantMenu() => restaurantMenu;
  static String getOrderDetail(int bookingId) => '$bookingDetail?bookingId=$bookingId';
  static String getConfirmOrder() => confirmBooking;
  static String getFoodDetail(int menuId) => '$menuDetail?menuId=$menuId';
  static String getRestaurantMenuFoodDetail(int foodId) =>
      '$venueMenuFood?foodId=$foodId';
  static String getCart() => cart;
  static String getPayments() => payments;
  static List<GetPage> routes = [
    GetPage(name: homepage, page: () => const Homepage()),
    GetPage(
      name: navigation,
      page: () => const Navigation(),
      transition: Transition.noTransition,
    ),
    GetPage(name: searchVenue, page: () =>  SearchVenuePage()),
    // GetPage(name: orders, page: () => const OrdersPage()),
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
