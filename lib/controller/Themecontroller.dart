// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  late bool _isDark;
  //
  bool get isDark => _isDark;

// constructor
  ThemeNotifier() {
    _isDark = false;
    _loadFrompref();
    notifyListeners();
  }

  //
  toogleTheme(bool value) {
    _isDark = value;
    notifyListeners();
    _savetopref();
  }
  // prefarence

  _loadFrompref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDark = preferences.getBool('theme') ?? false;
    notifyListeners();
    return _isDark;
  }

  // save
  _savetopref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('theme', _isDark);
  }
}
