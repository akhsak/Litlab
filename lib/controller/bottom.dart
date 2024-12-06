import 'package:flutter/material.dart';

import 'package:littlab/view/home_page.dart';
import 'package:littlab/view/my_learning.dart';
import 'package:littlab/view/settings_page.dart';
import 'package:littlab/view/wishlist.dart';

class BottomProvider extends ChangeNotifier {
  int currentIndex = 0;

  void onTap(index) {
    currentIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    HomePage(),
    MyLearning(),
    Wishlist(),
    SettingsPage(),
  ];
}
