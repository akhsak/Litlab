import 'package:flutter/material.dart';
import 'package:flutter_litltab/view/home_page.dart';
import 'package:flutter_litltab/view/settings_page.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;

  void onTap(index) {
    currentIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    HomePage(),
    SettingsPage(),
    // NotificationPage(),
    // UserProfileScreen(),
  ];
}
