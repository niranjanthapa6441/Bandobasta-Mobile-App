import 'package:BandoBasta/Pages/sign_in_page/sign_in_page_body.dart';
import 'package:flutter/material.dart';

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
          return false;
        },
      );
}
