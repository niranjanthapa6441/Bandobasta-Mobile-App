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
  static String userId = "1";
  static String orderId = "";
  static String orderStatus = "";
  static String menuFoodId = "";
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
  static String restaurantMenuURI = "";
  static String paymentsURI = "";
  static String ordersURI = "";
  static String categoryURI = "$apiVersion/category";
  static String mealURI = "$apiVersion/meal";
  static String paypalPaymentURI = "$apiVersion/payment/paypal";
  static String loginURI = "$apiVersion/user/login";
  static String registrationURI = "$apiVersion/user/registration";
  static String stripePaymentURI = "$apiVersion/payment/stripe";
  static String profileURI = "$apiVersion/user/$userId";
  static String saveOrderURI = "$apiVersion/order";


  static String ordersURi() {
    ordersURI =
        "$apiVersion/order/customer/$userId?size=$size&page=$page&period=$period&startDate=$startDate&endDate=$endDate&sortBy=$sortBy&status=$orderStatus";
    ;
    return ordersURI;
  }

  static String restaurantMenuURi() {
    restaurantMenuURI =
        "$apiVersion/menu/restaurant?sortBy=$sortBy&size=$size&category=$category&page=$page&restaurantId=$restaurantId&foodName=$foodName&rating=$rating";
    return restaurantMenuURI;
  }

  static String getVenueURI() {
    venueURI =
        "$apiVersion/venue?venueName=$venueName&page=$page&size=$size&maxCapacity=$maxCapacity&minCapacity=$minCapacity&veneuType=$venueType&rating=$rating";
    return venueURI;
  }
}
