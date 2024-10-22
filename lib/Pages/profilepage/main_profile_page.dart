import 'package:bandobasta/Pages/profilepage/profile_page_body.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: BigText(
            text: 'Checkout',
            color: Colors.white,
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: ProfilePageBody(),
      ),
      onWillPop: () async {
        return false;
      });
}
