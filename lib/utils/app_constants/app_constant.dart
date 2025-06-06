import 'package:BandoBasta/Response/user_profile_response.dart';
import 'package:BandoBasta/Response/venue_menu_response.dart';
import 'package:BandoBasta/Response/venue_hall_response.dart';

class AppConstant {
  static const String appName = "BandoBasta";
  static const String baseURL = "https://bandobasta.onrender.com/bandobasta";
  // static const String baseURL = "http://192.168.1.66:8080/bandobasta";

  static String apiVersion = "/api/v1";

  static bool toFood = false;
  static bool hasValue = false;
  static bool isAccountRegistered = false;
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
      menuItemSelectionRangeDetails: []);
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
  static User user = User(
      id: 0,
      firstName: '',
      lastName: '',
      middleName: '',
      email: '',
      phoneNumber: '');

  static int hallIndex = 0;
  static int menuIndex = 0;
  static String email = "";
  static String otp = "";
  static int foodId = 0;
  static String numberOfItems = "";
  static String orderId = "";
  static String bookingStatus = "";
  static String menuFoodId = "";
  static String menuType = "";
  static String category = "";
  static String meal = "";
  static double rating = 0.0;
  static String venueName = "";
  static int page = 1;
  static int size = 5;
  static int numberOfGuests = 100;
  static String period = "";
  static String startDate = "";
  static String endDate = "";
  static String selectedDate = "";
  static String selectedTime = "";
  static String menuId = "";
  static String eventType = "WEDDING";
  static String venueType = "";
  static int minCapacity = 0;
  static int maxCapacity = 0;
  static String hallId = "";
  static String ticketOrderId = "";

  static String sortBy = "";
  static String username = "";
  static String venueURI = "";
  static String venueMenusURI = "";
  static String paymentsURI = "";
  static String findHallBookingByUser = "";
  static String categoryURI = "$apiVersion/category";
  static String mealURI = "$apiVersion/meal";
  static String paypalPaymentURI = "$apiVersion/payment/paypal";
  static String signInURL = "";
  static String signUpURL = "";
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
  static String updateProfileURL = "";
  static String userProfileURL = "";
  static String sendOTPEmailURL = "";
  static String verifyOTPURL = "";
  static String resetPasswordURL = "";
  static String verifyAccountURL = "";
  static String availableVenueURI = "";
  static String allTicketsByEventURI = "";
  static String checkInURI = "";
  static String eventId = "1";
  static String countOfBookedAndCheckInTicketURI = "";
  static bool isFeaturedVenueSelected = false;

  static String getHallBookingURI(String? userId) {
    findHallBookingByUser =
        "$apiVersion/booking/hall/user?userId=$userId&page=$page&size=$size&bookingStatus=$bookingStatus&startDate=$startDate&endDate=$endDate";
    return findHallBookingByUser;
  }

  static String getVenueMenusURI() {
    venueMenusURI =
        "$apiVersion/menu/findAll?venueId=$venueId&page=$page&size=$size&menuType=$menuType";
    return venueMenusURI;
  }

  static String getVenueURI() {
    venueURI =
        "$apiVersion/venue/findAll?venueName=$venueName&page=$page&size=$size&maxCapacity=$maxCapacity&minCapacity=$minCapacity&minPrice=$minPrice&maxPrice=$maxPrice&location=$address&rating=$rating";
    return venueURI;
  }

  static String getVenueHallsURI() {
    venueHallURI =
        "$apiVersion/hall/findAll?venueId=$venueId&checkAvailableDate=$selectedDate&numberOfGuests=$numberOfGuests&page=$page&size=$size";
    return venueHallURI;
  }

  static String getVenuePackagesURI() {
    venuePackageURI =
        "$apiVersion/package/findAll?venueId=$venueId&page=$page&size=$size";
    return venuePackageURI;
  }

  static String getHallAvailabilitiesURL() {
    hallAvailabilitiesURL =
        "$apiVersion/hall/availability?venueId=$venueId&hallId=$hallId&date=$selectedDate&page=$page&size=$size";
    return hallAvailabilitiesURL;
  }

  static String getSaveHallBookingURL() {
    saveHallBookingURL = "$apiVersion/booking/hall";
    return saveHallBookingURL;
  }

  static String getSignInURL() {
    signInURL = "$apiVersion/user/authenticate/login";
    return signInURL;
  }

  static String getSignUpURL() {
    signUpURL = "$apiVersion/user/authenticate/register";
    return signUpURL;
  }

  static String getUpdateProfileURL(String? userId) {
    updateProfileURL = "$apiVersion/user/$userId";
    return updateProfileURL;
  }

  static String getProfileURL(String? userId) {
    userProfileURL = "$apiVersion/user/$userId";
    return userProfileURL;
  }

  static String getVerifyOTPURL(String otp) {
    verifyOTPURL = "$apiVersion/user/validateOTP?otp=$otp";
    return verifyOTPURL;
  }

  static String getSendOTPEmailURL() {
    sendOTPEmailURL = "$apiVersion/user/forgotPassword";
    return sendOTPEmailURL;
  }

  static String getResetPasswordURL() {
    resetPasswordURL = "$apiVersion/user/resetUserPassword";
    return resetPasswordURL;
  }

  static String getVerifyAccountURL(String token) {
    verifyAccountURL =
        "$apiVersion/user/authenticate/register/confirm?token=$token";
    return verifyAccountURL;
  }

  static String getAvailableVenueURI() {
    availableVenueURI =
        "$apiVersion/venue/checkVenueAvailability?checkAvailableDate=$selectedDate&numberOfGuests=$numberOfGuests&venueName=$venueName&page=$page&size=$size&maxCapacity=$maxCapacity&minCapacity=$minCapacity&minPrice=$minPrice&maxPrice=$maxPrice&location=$address&rating=$rating";
    return availableVenueURI;
  }

  static String getAllTicketsByEventURI(int page, int size) {
    allTicketsByEventURI =
        "$apiVersion/event/order/findAllTicketOrderByEvent?eventId=$eventId&page=$page&size=$size&ticketOrderId=$ticketOrderId";
    return allTicketsByEventURI;
  }

  static String checkIn(String ticketOrderId) {
    checkInURI = "$apiVersion/event/order/checkIn?ticketOrderId=$ticketOrderId";
    return checkInURI;
  }

  static String getCountOfCheckedInAndBookedTicketsByEventURI() {
    countOfBookedAndCheckInTicketURI =
        "$apiVersion/event/order/countOfBookedAndCheckedInTicket?eventId=$eventId";

    return countOfBookedAndCheckInTicketURI;
  }
}
