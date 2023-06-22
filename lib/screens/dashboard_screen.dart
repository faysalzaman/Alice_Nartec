import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grosshop/utils/strings.dart';
import 'package:line_icons/line_icons.dart';
import 'package:grosshop/screens/dashboard/home_screen.dart';
import 'package:grosshop/screens/dashboard/order_screen.dart';
import 'package:grosshop/screens/dashboard/profile_screen.dart';
import 'package:grosshop/screens/dashboard/my_cart_screen.dart';

import 'dashboard/cart_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.green[300]!,
              hoverColor: Colors.green[100]!,
              gap: 8,
              color: Colors.black,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.green[100]!,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: Strings.home,
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: Strings.cart,
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: Strings.profile,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(
                  () {
                    _selectedIndex = index;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
