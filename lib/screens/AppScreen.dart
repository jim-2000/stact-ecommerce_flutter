import 'package:flutter/material.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/screens/Landing/Landing.dart';
import 'package:stack/screens/upload/uploadProductScreen.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomNavScreen(),
        // LandingScreen(),
        UploadProductScreen(),
      ],
    );
  }
}
