import 'package:bandobasta/Controller/booking_controller.dart';
import 'package:bandobasta/Controller/check_hall_availability_controller.dart';
import 'package:bandobasta/Controller/venue_controller.dart';
import 'package:bandobasta/Controller/venue_hall_controller.dart';
import 'package:bandobasta/Controller/venue_menu_controller.dart';
import 'package:bandobasta/Controller/venue_package_controller.dart';
import 'package:bandobasta/Pages/homepage/navigation.dart';
import 'package:bandobasta/Pages/sign_in_page/sign_in.dart';
import 'package:bandobasta/Pages/sign_up_page/sign_up.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandobasta/utils/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<VenueController>().onClose();
    Get.find<VenueController>().get();
    Get.find<BookingController>().onClose();
    Get.find<BookingController>().get();
    Get.find<VenueMenuController>().onClose();
    Get.find<VenueMenuController>().get();
    Get.find<VenueHallController>().onClose();
    Get.find<VenueHallController>().get();
    Get.find<VenuePackageController>().onClose();
    Get.find<VenuePackageController>().get();
    Get.find<HallAvailabilityController>().onClose();
    Get.find<HallAvailabilityController>().get();
    return GetMaterialApp(
      title: 'Bandobasta',
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 176, 2, 2),
          appBarTheme: const AppBarTheme(
            color: const Color.fromARGB(255, 176, 2, 2),
          )),
      debugShowCheckedModeBanner: false,
      getPages: RouteHelper.routes,
      home: SignInPage(),
    );
  }
}
