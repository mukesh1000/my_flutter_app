import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_flutter_app/Admin/Admin.dart';
import 'package:my_flutter_app/Admin/upload.dart';
import 'package:my_flutter_app/Homepage.dart';
import 'package:my_flutter_app/Post.dart';
import 'package:my_flutter_app/Profile_screen.dart';
import 'package:my_flutter_app/Search.dart';

class AdminNavbar extends StatefulWidget {
  const AdminNavbar({super.key});

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  int _selectedIndex = 0;
  List<Widget> _widgetoptions = <Widget>[
    MyAdmin(),
    upload(),
    MySearch(),
    ProfileScreen(),
  ];

  //final screen = [const MyHomepage(), const MyPost(), const MySearch(), const ProfileScreen(), ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetoptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(116, 192, 67, 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              activeColor: Colors.black,
              iconSize: 24,
              //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              backgroundColor: Color.fromRGBO(116, 192, 67, 1),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              padding: EdgeInsets.all(8),
              gap: 8,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Posts',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(icon: Icons.account_circle, text: 'Profile'),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
