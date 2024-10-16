class AppConstant {
  static const String appName = "Bandobasta";
  static const String baseURL = "http://127.0.0.1:8080/book-eat-nepal";
  static String apiVersion = "/api/v1";

  static bool toFood = false;
  static bool hasValue = false;
  static bool toCart = false;
  static bool toRestaurantMenu = false;

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
}
