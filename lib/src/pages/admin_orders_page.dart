import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/orders_state.dart';
import '../services/export_service.dart';
import 'admin_dashboard_page.dart';

class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersState>().orders.reversed.toList();
    final filtered = _filter == 'All' ? orders : orders.where((o) => o.status == _filter).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Orders'), actions: [
        IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminDashboardPage())), icon: const Icon(Icons.dashboard)),
        IconButton(onPressed: () {
          final csv = ExportService.ordersToCsv(orders);
          showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Export CSV'), content: SelectableText(csv), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))]));
        }, icon: const Icon(Icons.download)),
      ]),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12.0), child: Row(children: [
          const Text('Filter:'),
          const SizedBox(width: 8),
          DropdownButton<String>(value: _filter, items: const [DropdownMenuItem(value: 'All', child: Text('All')), DropdownMenuItem(value: 'Pending', child: Text('Pending')), DropdownMenuItem(value: 'Processing', child: Text('Processing')), DropdownMenuItem(value: 'Shipped', child: Text('Shipped')), DropdownMenuItem(value: 'Delivered', child: Text('Delivered'))], onChanged: (v) => setState(() => _filter = v ?? 'All')),
        ])),
        Expanded(child: filtered.isEmpty ? const Center(child: Text('No orders')) : ListView.separated(itemCount: filtered.length, separatorBuilder: (_,__)=>const SizedBox(height:8), itemBuilder: (context,i){
          final o = filtered[i];
          return Card(child: Padding(padding: const EdgeInsets.all(12.0), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Order #${o.id}'), Text(o.status, style: const TextStyle(color: Colors.orange))]),
            const SizedBox(height:8),
            ...o.items.map((it)=>Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${it.name} x${it.qty}'), Text('Rp ${it.price.toStringAsFixed(0)}')] )),
            const Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total', style: const TextStyle(fontWeight: FontWeight.bold)), Text('Rp ${o.total.toStringAsFixed(0)}')]),
            const SizedBox(height:6),
            Text('Alamat: ${o.address}', style: const TextStyle(fontSize: 12)),
          ])));
        }))
      ]),
    );
  }
}