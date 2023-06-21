import 'package:flutter/material.dart';

class MainPageViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool isScrolling = true;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
