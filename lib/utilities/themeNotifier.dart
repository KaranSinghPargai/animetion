import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeNotifier extends ChangeNotifier {
  bool darkMode = true;

  toggleTheme() {
    darkMode = !darkMode;
    notifyListeners();
  }
}
