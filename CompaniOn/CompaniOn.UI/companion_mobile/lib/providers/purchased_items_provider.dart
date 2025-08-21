import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PurchasedItemsProvider extends ChangeNotifier {
  Set<String> _purchasedItems = {};
  final String _key = 'purchased_items';
  
  PurchasedItemsProvider() {
    _loadPurchasedItems();
  }

  bool isItemPurchased(String itemName) {
    return _purchasedItems.contains(itemName);
  }

  Future<void> _loadPurchasedItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? storedData = prefs.getString(_key);
      if (storedData != null) {
        final List<dynamic> decoded = jsonDecode(storedData);
        _purchasedItems = Set<String>.from(decoded);
      }
    } catch (e) {
      debugPrint('Error loading purchased items: $e');
      _purchasedItems = {};
    }
    notifyListeners();
  }

  Future<void> addPurchasedItem(String itemName) async {
    _purchasedItems.add(itemName);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, jsonEncode(_purchasedItems.toList()));
    } catch (e) {
      debugPrint('Error saving purchased items: $e');
    }
    notifyListeners();
  }
}