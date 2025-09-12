import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final double totalPrice;

  const CheckoutPage({
    Key? key,
    required this.cartItems,
    required this.totalPrice,
  }) : super(key: key);

  void _sendNotification(BuildContext context) {
    // Simulasi pengiriman data ke halaman notifikasi
    Navigator.pushNamed(
      context,
      '/notification',
      arguments: {
        'message': 'Checkout berhasil!',
        'cartItems': cartItems,
        'totalPrice': totalPrice,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Qty: ${item['quantity']}'),
                    trailing: Text('Rp${item['price']}'),
                  );
                },
              ),
            ),
            Text('Total: Rp$totalPrice', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _sendNotification(context),
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}