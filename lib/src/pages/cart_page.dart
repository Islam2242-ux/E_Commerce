import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';
import '../theme/app_theme.dart';
import 'notifikasi_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Rp ${cart.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.deepBlue)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: cart.items.isEmpty
                          ? null
                          : () {
                              final checkoutItems = List.from(cart.items);
                              final checkoutTotal = cart.totalPrice;
                              cart.clear(); // gunakan method yang sudah ada
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NotifikasiPage(
                                    checkoutItems: checkoutItems,
                                    checkoutTotal: checkoutTotal,
                                  ),
                                ),
                              );
                            },
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: cart.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final item = cart.items[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(item.image,
                            width: 64, height: 64, fit: BoxFit.cover),
                      ),
                      title: Text(item.name,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                          'Rp ${(item.price * item.qty).toStringAsFixed(0)}'),
                      trailing: SizedBox(
                        width: 160,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => cart.decrease(item.id),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${item.qty}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            IconButton(
                              onPressed: () => cart.increase(item.id),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                            IconButton(
                              onPressed: () => cart.remove(item.id),
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
