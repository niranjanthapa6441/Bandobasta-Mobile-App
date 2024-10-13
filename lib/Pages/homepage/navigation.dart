
import 'package:bandobasta/Pages/bookingPage/orders_page.dart';
import 'package:bandobasta/Pages/homepage/homepage.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List pages = [
    const Homepage(),
    const BookingsPage(),
    // const PaymentDetailsPage(),
    // const ProfilePage(),
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
              Icons.payment,
              size: Dimensions.height30,
            ),
            label: 'Billings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: Dimensions.height30,
            ),
            label: 'Profile',
          ),
        ],
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
