import 'package:stack/screens/cart_screen.dart';
import 'package:stack/screens/feedScreen.dart';
import 'package:stack/screens/homeScreen.dart';
import 'package:stack/screens/searchScreen.dart';
import 'package:stack/screens/userScreen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  static const routesName = "bottom/route";
  BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
//

  List _pages = const [
    HomeScreen(),
    FeedsScreen(),
    SearchScreen(),
    CartScreen(),
    UserScreen(),
  ];
  //
  int _currentIndex = 0;
  //
  _ontap(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _ontap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed), label: "Feed", tooltip: "feed"),
          BottomNavigationBarItem(icon: Icon(null), label: "", tooltip: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Cart", tooltip: "cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "User", tooltip: "User"),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "search",
        onPressed: () {
          _ontap(2);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
