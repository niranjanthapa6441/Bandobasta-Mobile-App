import 'package:BandoBasta/Pages/AccountAndSettings/main_profile_page.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/venue_info_page.dart';
import 'package:BandoBasta/Pages/authenticate/otp/otp.dart';
import 'package:BandoBasta/Pages/authenticate/otp/email_otp.dart';
import 'package:BandoBasta/Pages/authenticate/reset_password_page.dart';
import 'package:BandoBasta/Pages/bookingPage/availability_page.dart';
import 'package:BandoBasta/Pages/bookingPage/checkout_page.dart';
import 'package:BandoBasta/Pages/bookingPage/select_hall_package_page.dart';
import 'package:BandoBasta/Pages/homepage/homepage.dart';
import 'package:BandoBasta/Pages/homepage/navigation.dart';
import 'package:BandoBasta/Pages/menuPage/food_menu_page.dart';
import 'package:BandoBasta/Pages/menuPage/venue_menu_page.dart';
import 'package:BandoBasta/Pages/AccountAndSettings/updateProfilePage.dart';
import 'package:BandoBasta/Pages/bookingPage/check_availability_form_page.dart';
import 'package:BandoBasta/Pages/searchVenuePage/search_venue_page.dart';
import 'package:BandoBasta/Pages/authenticate/sign_in_page/sign_in.dart';
import 'package:BandoBasta/Pages/authenticate/sign_up_page/sign_up.dart';
import 'package:BandoBasta/Pages/venueHallPage/hall_info.dart';
import 'package:BandoBasta/Pages/venueHallPage/venue_halls.dart';
import 'package:BandoBasta/Pages/venuePackage/package_info.dart';
import 'package:BandoBasta/Pages/venuePackage/venue_packages.dart';
import 'package:BandoBasta/Response/venue_menu_response.dart';
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
  static const String updateProfile = '/updateProfile';
  static const String viewNotifications = '/viewNotifications';
  static const String venueMenus = '/venueMenus';
  static const String menuDetail = '/menudetail';
  static const String venueHalls = '/venueHalls';
  static const String venueHallInfo = '/venueHallInfo';
  static const String venuePackages = '/venuePackages';
  static const String venuePackageInfo = '/venuePackageInfo';
  static const String selectHallVenuePackage = '/selectHallVenuePackage';
  static const String bookingDetail = '/orderDetail';
  static const String cart = '/cart';
  static const String confirmBooking = '/confirmBooking';
  static const String venueMenuFood = '/venue/menu/food';
  static const String bookingConfirmationPage = '/booking/confirmation';
  static const String availableDateTime = '/getAvailableTime';
  static const String checkAvailabilityForm = '/checkAvailabilityForm';
  static const String getEmailForOTP = '/getEmailForOTP';
  static const String verifyOTP = '/verifyOTP';
    static const String resetPassword = '/resetPassword';


  static String getInitial() => initial;
  static String getNavigation() => navigation;
  static String getSignIn() => signIn;
  static String getSignUp() => signUp;
  static String getEmailOTP() => getEmailForOTP;
  static String getVerifyOTP() => verifyOTP;
  static String getResetPasswordPage() => resetPassword;


  static String getBookingConfirmationPage() => bookingConfirmationPage;
  static String getVenueInfo(int pageId) => '$venueInfo?pageId=$pageId';
  static String getHallInfo(int pageId, String venueName, String imageURL) =>
      '$venueHallInfo?pageId=$pageId&imageURL=$imageURL&venueName=$venueName';
  static String getPackageInfo(int pageId, String venueName, String imageURL) =>
      '$venuePackageInfo?pageId=$pageId&imageURL=$imageURL&venueName=$venueName';
  static String getMenuDetail(String menuName, String price) =>
      '$menuDetail?menuName=$menuName&price=$price';
  static String getHomepage() => homepage;
  static String getSearchVenue() => searchVenue;
  static String getOrders() => bookings;
  static String getUpdateProfile() => updateProfile;
  static String getViewProfile() => viewProfile;
  static String getViewNotiifcations() => viewNotifications;
  static String getVenueHalls(String venueName, String imageURL) =>
      '$venueHalls?venueName=$venueName&imageURL=$imageURL';
  static String getVenueMenus(String venueName, String imageURL) =>
      '$venueMenus?venueName=$venueName&imageURL=$imageURL';
  static String getVenuePackages(String venueName, String imageURL) =>
      '$venuePackages?venueName=$venueName&imageURL=$imageURL';
  static String getOrderDetail(int bookingId) =>
      '$bookingDetail?bookingId=$bookingId';
  static String getConfirmOrder() => confirmBooking;
  static String getRestaurantMenuFoodDetail(int foodId) =>
      '$venueMenuFood?foodId=$foodId';
  static String getAvailableDateTime() => availableDateTime;
  static String getCheckAvailabilityForm() => checkAvailabilityForm;

  static String getSelectHallPackagePage(String venueName, String imageURL) =>
      '$selectHallVenuePackage?venueName=$venueName&imageURL=$imageURL';

  static List<GetPage> routes = [
    GetPage(name: homepage, page: () => const Homepage()),
    GetPage(name: signUp, page: () => const SignUpPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: getEmailForOTP, page: () => const GetEmailOTP()),
    GetPage(name: verifyOTP, page: () => OTPPage()),
    GetPage(name: resetPassword, page: () => const ResetPasswordPage()),

    GetPage(
      name: navigation,
      page: () => const Navigation(),
      transition: Transition.noTransition,
    ),
    GetPage(name: searchVenue, page: () => SearchVenuePage()),
    GetPage(name: viewProfile, page: () => ProfilePage()),
    GetPage(name: updateProfile, page: () => const UpdateProfilePage()),
    GetPage(name: bookingConfirmationPage, page: () => const CheckoutPage()),
    GetPage(name: availableDateTime, page: () => const AvailabilityPage()),
    GetPage(
        name: checkAvailabilityForm, page: () => const CheckAvailabilityPage()),
    GetPage(
        name: selectHallVenuePackage,
        page: () {
          var name = Get.parameters['venueName'];
          var imageURL = Get.parameters['imageURL'];
          return SelectHallPackagePage(
            venueName: name!,
            imageURL: imageURL!,
          );
        }),
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
          var imageURL = Get.parameters['imageURL'];
          return VenueHallPage(
            venueName: name!,
            imageURL: imageURL!,
          );
        }),
    GetPage(
        name: venuePackages,
        page: () {
          var name = Get.parameters['venueName'];
          var imageURL = Get.parameters['imageURL'];

          return VenuePackagePage(venueName: name!, imageURL: imageURL!);
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
          var venueName = Get.parameters['venueName'];
          var imageURL = Get.parameters['imageURL'];
          return HallInfoPage(
            pageId: int.parse(pageId!),
            venueName: venueName!,
            imageURL: imageURL!,
          );
        }),
    GetPage(
        name: venuePackageInfo,
        page: () {
          var pageId = Get.parameters['pageId'];
          var venueName = Get.parameters['venueName'];
          var imageURL = Get.parameters['imageURL'];
          return PackageInfoPage(
            pageId: int.parse(pageId!),
            venueName: venueName!,
            imageURL: imageURL!,
          );
        }),
    GetPage(
        name: menuDetail,
        page: () {
          var menuName = Get.parameters['menuName'];
          var price = Get.parameters['price'];
          MenuDetail menuDetail = Get.arguments as MenuDetail;
          return FoodMenuScreen(
              menuDetail: menuDetail, menuName: menuName!, price: price!);
        }),
  ];
}
