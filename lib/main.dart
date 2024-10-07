import 'package:bandobasta/Pages/homepage/homepage.dart';
import 'package:bandobasta/pages/homepage/navigation.dart';
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
    // Get.find<FoodController>().onClose();

    return GetMaterialApp(
      title: 'Cloud Kitchen',
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 176, 2, 2),
          appBarTheme: const AppBarTheme(
            color: const Color.fromARGB(255, 176, 2, 2),
          )),
      debugShowCheckedModeBanner: false,
      getPages: RouteHelper.routes,
      home: Navigation(),
    );
  }
}
