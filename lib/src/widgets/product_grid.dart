import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';
import 'product_tile.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .74,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, i) {
        final p = products[i];
        return ProductTile(
          name: p['name'] as String,
          price: p['price'] as double,
          image: p['image'] as String,
          onAdd: () {
            context.read<CartState>().add(
                  p['id'] as String,
                  p['name'] as String,
                  p['image'] as String,
                  p['price'] as double,
                );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${p['name']} ditambahkan ke keranjang')),
            );
          },
        );
      },
    );
  }
}
