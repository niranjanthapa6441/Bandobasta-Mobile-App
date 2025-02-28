import 'package:BandoBasta/Pages/AccountAndSettings/account_settings_page.dart';
import 'package:BandoBasta/Pages/bookingPage/view_bookings_page.dart';
import 'package:BandoBasta/Pages/favouritePage/favourites_page.dart';
import 'package:BandoBasta/Pages/homepage/homepage.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List pages = [
    Homepage(),
    BookingsPage(),
    FavouritesPage(),
    AccountSettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: Dimensions.height30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              size: Dimensions.height30,
            ),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: Dimensions.height30,
            ),
            label: 'Visitors',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: Dimensions.height30,
            ),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedLabelStyle: TextStyle(
            fontSize: Dimensions.font15,
            color: Color.fromARGB(218, 39, 41, 39)),
        unselectedItemColor: const Color.fromARGB(218, 39, 41, 39),
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          fontSize: Dimensions.font10 * 1.6,
        ),
        selectedItemColor: AppColors.themeColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
