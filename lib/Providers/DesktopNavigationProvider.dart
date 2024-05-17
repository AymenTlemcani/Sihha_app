import 'package:flutter/material.dart';

class DesktopNavigationProvider extends ChangeNotifier {
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void navigateToNewPage(Widget page) {
    // Implement navigation logic here
    notifyListeners();
  }
}
