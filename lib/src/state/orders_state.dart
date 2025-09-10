import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderItem {
  final String id;
  final String name;
  final double price;
  final int qty;
  OrderItem({required this.id, required this.name, required this.price, required this.qty});

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'price': price, 'qty': qty};
  static OrderItem fromJson(Map<String, dynamic> j) => OrderItem(id: j['id'], name: j['name'], price: j['price'] + 0.0, qty: j['qty']);
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double total;
  String address;
  String status;
  final DateTime createdAt;
  Order({required this.id, required this.items, required this.total, required this.address, required this.status, DateTime? createdAt}) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {'id': id, 'items': items.map((e) => e.toJson()).toList(), 'total': total, 'address': address, 'status': status, 'createdAt': createdAt.toIso8601String()};
  static Order fromJson(Map<String, dynamic> j) => Order(id: j['id'], items: (j['items'] as List).map((e) => OrderItem.fromJson(e)).toList(), total: j['total'] + 0.0, address: j['address'], status: j['status'], createdAt: DateTime.parse(j['createdAt']));
}

class OrdersState extends ChangeNotifier {
  final List<Order> _orders = [];
  final Map<String, Timer> _timers = {};

  List<Order> get orders => List.unmodifiable(_orders);

  OrdersState() {
    _load();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    final s = p.getString('orders_json') ?? '[]';
    try {
      final arr = jsonDecode(s) as List;
      _orders.clear();
      for (final e in arr) {
        final o = Order.fromJson(e);
        _orders.add(o);
        _maybeStartTimer(o);
      }
      notifyListeners();
    } catch (ex) {}
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('orders_json', jsonEncode(_orders.map((e) => e.toJson()).toList()));
  }

  Future<void> createOrder(List<OrderItem> items, double total, String address) async {
    final o = Order(id: DateTime.now().millisecondsSinceEpoch.toString(), items: items, total: total, address: address, status: 'Pending');
    _orders.add(o);
    _maybeStartTimer(o);
    await _save();
    notifyListeners();
  }

  Future<void> clearOrders() async {
    for (final t in _timers.values) t.cancel();
    _timers.clear();
    _orders.clear();
    final p = await SharedPreferences.getInstance();
    await p.remove('orders_json');
    notifyListeners();
  }

  void _maybeStartTimer(Order o) {
    if (_timers.containsKey(o.id)) return;
    // Each order gets its own timer that advances its status every 6-12 seconds (random-ish)
    final dur = Duration(seconds: 6 + (o.id.hashCode % 7));
    _timers[o.id] = Timer.periodic(dur, (t) {
      final idx = _orders.indexWhere((x) => x.id == o.id);
      if (idx == -1) { t.cancel(); _timers.remove(o.id); return; }
      final ord = _orders[idx];
      if (ord.status == 'Pending') ord.status = 'Processing';
      else if (ord.status == 'Processing') ord.status = 'Shipped';
      else if (ord.status == 'Shipped') { ord.status = 'Delivered'; t.cancel(); _timers.remove(o.id); }
      _save();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    for (final t in _timers.values) t.cancel();
    _timers.clear();
    super.dispose();
  }
}