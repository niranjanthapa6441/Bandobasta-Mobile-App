import 'package:BandoBasta/Pages/sign_in_page/sign_in_page_body.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) => WillPopScope(
        child: Scaffold(
          body: SignInPageBody(),
        ),
        onWillPop: () async {
          Get.toNamed(RouteHelper.getNavigation());
          return false;
        },
      );
}
