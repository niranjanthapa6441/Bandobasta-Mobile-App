import 'package:bandobasta/Response/venue_menu_response.dart';
import 'package:bandobasta/Response/venue_hall_response.dart';

class AppConstant {
  static const String appName = "Bandobasta";
  static const String baseURL = "http://127.0.0.1:8080/book-eat-nepal";
  static String apiVersion = "/api/v1";

  static bool toFood = false;
  static bool hasValue = false;
  static bool toCart = false;
  static bool isSelectHallPackageSelected = false;
  static bool isHallBooking = false;
  static MenuDetail menuDetail = MenuDetail(
    id: '',
    venueId: '',
    description: '',
    price: 0.0,
    status: '',
    menuType: '',
    foodDetails: [],
  );
  static HallDetail hallDetail = HallDetail(
    venueId: '',
    id: 0,
    name: '',
    description: '',
    floorNumber: 0,
    capacity: 0,
    status: '',
    hallImagePaths: [],
  );
  static int hallIndex = 0;
  static int menuIndex = 0;

  static int foodId = 0;
  static String numberOfItems = "";
  static String userId = "2";
  static String orderId = "";
  static String orderStatus = "";
  static String menuFoodId = "";
  static String menuType = "";
  static String category = "";
  static String meal = "";
  static double rating = 0.0;
  static String venueName = "";
  static int page = 1;
  static int size = 5;
  static String period = "";
  static String startDate = "";
  static String endDate = "";
  static String selectedDate = "";
  static String selectedTime = "";
  static String menuId = "";
  static String eventType = "WEDDING";

  static String venueType = "";
  static int minCapacity = 0;
  static int maxCapacity = 10000;

  static String paymentStartDate = "";
  static String paymentEndDate = "";
  static String paymentMethod = "";
  static String paymentPartner = "";
  static String sortBy = "";
  static String foodName = "";
  static String restaurantId = "";
  static String username = "niranjan";
  static String latitude = "";
  static String longitude = "";
  static String userURI = "/user";
  static String searchFoodsURI = "";
  static String venueURI = "";
  static String venueMenusURI = "";
  static String paymentsURI = "";
  static String findHallBookingByUser = "";
  static String categoryURI = "$apiVersion/category";
  static String mealURI = "$apiVersion/meal";
  static String paypalPaymentURI = "$apiVersion/payment/paypal";
  static String loginURI = "$apiVersion/user/login";
  static String registrationURI = "$apiVersion/user/registration";
  static String stripePaymentURI = "$apiVersion/payment/stripe";
  static String profileURI = "$apiVersion/user/$userId";
  static String saveOrderURI = "$apiVersion/order";
  static String address = "";
  static double minPrice = 0.0;
  static double maxPrice = 0.0;
  static String venueId = "";
  static String venueImageURL = "";
  static String venueHallURI = "";
  static String venuePackageURI = "";
  static String hallAvailabilitiesURL = "";
  static String hallAvailabilityId = "";
  static String saveHallBookingURL = "";

  static String getHallBookingURI() {
    findHallBookingByUser =
        "$apiVersion/booking/hall/user?userId=$userId&page=$page&size=$size";
    return findHallBookingByUser;
  }

  static String getVenueMenusURI() {
    venueMenusURI =
        "$apiVersion/menu?venueId=$venueId&page=$page&size=$size&menuType=$menuType";
    return venueMenusURI;
  }

  static String getVenueURI() {
    venueURI =
        "$apiVersion/venue?venueName=$venueName&page=$page&size=$size&maxCapacity=$maxCapacity&minCapacity=$minCapacity&minPrice=$minPrice&maxPrice=$maxPrice&location=$address&rating=$rating";
    return venueURI;
  }

  static String getVenueHallsURI() {
    venueHallURI = "$apiVersion/hall?venueId=$venueId&page=$page&size=$size";
    return venueHallURI;
  }

  static String getVenuePackagesURI() {
    venuePackageURI =
        "$apiVersion/package?venueId=$venueId&page=$page&size=$size";
    return venuePackageURI;
  }

  static String getHallAvailabilitiesURL() {
    hallAvailabilitiesURL =
        "$apiVersion/hall/availability?venueId=$venueId&date=$selectedDate&page=$page&size=$size";
    return hallAvailabilitiesURL;
  }
  static String getSaveHallBookingURL() {
    saveHallBookingURL =
        "$apiVersion/booking/hall";
    return saveHallBookingURL;
  }
}
