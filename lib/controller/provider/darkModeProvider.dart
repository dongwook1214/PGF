import 'package:flutter/material.dart';

class DarkModeProvider with ChangeNotifier {
  bool _isDarkMode;

  DarkModeProvider(this._isDarkMode);

  bool get isDarkMode => _isDarkMode;
  void setIsDarkMode(bool _bool) {
    _isDarkMode = _bool;
    notifyListeners();
  }
}
