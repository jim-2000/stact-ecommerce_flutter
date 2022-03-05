import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/screens/AppScreen.dart';
import 'package:stack/screens/Landing/Landing.dart';
import 'package:stack/screens/homeScreen.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const AppScreen();
          } else {
            return const LandingScreen();
          }
        }
        return const LandingScreen();
      },
    );
  }
}
