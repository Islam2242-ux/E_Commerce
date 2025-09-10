import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MockApi {
  static List<dynamic> products = [];
  static List<dynamic> categories = [];
  static List<dynamic> chats = [];

  static Future<void> loadAssets() async {
    try {
      final p = await rootBundle.loadString('assets/mock_db/products.json');
      final c = await rootBundle.loadString('assets/mock_db/categories.json');
      final ch = await rootBundle.loadString('assets/mock_db/chats.json');
      products = jsonDecode(p) as List<dynamic>;
      categories = jsonDecode(c) as List<dynamic>;
      chats = jsonDecode(ch) as List<dynamic>;
    } catch (ex) {}
  }
}