import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/orders_state.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersState>().orders;
    final totalOrders = orders.length;
    final pending = orders.where((o) => o.status == 'Pending').length;
    final totalRevenue = orders.fold<double>(0.0, (p, o) => p + o.total);
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Card(child: ListTile(title: const Text('Total Orders'), trailing: Text('$totalOrders'))),
          const SizedBox(height:8),
          Card(child: ListTile(title: const Text('Pending Orders'), trailing: Text('$pending'))),
          const SizedBox(height:8),
          Card(child: ListTile(title: const Text('Total Revenue'), trailing: Text('Rp ${totalRevenue.toStringAsFixed(0)}'))),
        ]),
      ),
    );
  }
}