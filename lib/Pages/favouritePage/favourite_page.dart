import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height10 * 8,
        automaticallyImplyLeading: false,
        elevation: 0, // No shadow
        backgroundColor: Colors.white,
        title: Center(
          child: Container(
            height: Dimensions.height10 * 9,
            width: Dimensions.height10 * 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/logo.png"), // Your logo image
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
