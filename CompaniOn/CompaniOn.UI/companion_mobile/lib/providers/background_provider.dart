import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BackgroundProvider extends ChangeNotifier {
  String _currentBackground = '';
  final String _key = 'current_background';
  
  BackgroundProvider() {
    _loadSavedBackground();
  }

  String get currentBackground => _currentBackground;

  Future<void> _loadSavedBackground() async {
    final prefs = await SharedPreferences.getInstance();
    _currentBackground = prefs.getString(_key) ?? '';
    notifyListeners();
  }

  Future<void> updateBackground(String newBackground) async {
    _currentBackground = newBackground;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, newBackground);
    notifyListeners();
  }
}