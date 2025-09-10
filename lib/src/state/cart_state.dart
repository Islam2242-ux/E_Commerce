import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  int qty;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.qty = 1,
  });
}

class CartState extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get totalCount => _items.values.fold(0, (p, e) => p + e.qty);

  double get totalPrice => _items.values.fold(0.0, (p, e) => p + e.price * e.qty);

  void add(String id, String name, String image, double price) {
    if (_items.containsKey(id)) {
      _items[id]!.qty += 1;
    } else {
      _items[id] = CartItem(id: id, name: name, image: image, price: price);
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void increase(String id) {
    if (_items.containsKey(id)) {
      _items[id]!.qty += 1;
      notifyListeners();
    }
  }

  void decrease(String id) {
    if (_items.containsKey(id)) {
      if (_items[id]!.qty > 1) {
        _items[id]!.qty -= 1;
      } else {
        _items.remove(id);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}