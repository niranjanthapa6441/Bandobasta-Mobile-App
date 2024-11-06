import 'package:BandoBasta/Pages/AccountAndSettings/profile_page_body.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: BigText(
          text: 'Profile',
          color: Colors.white,
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: ProfilePageBody(),
    );
  }
}
