import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/categories_widget.dart';
import '../widgets/product_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search = '';
  String? _selectedCategory;

  // Contoh data produk
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Kaos Polos',
      'category': 'Outfit',
      'price': 50000.0,
      'image': 'assets/images/prod_outfit.png',
    },
    {
      'id': '2',
      'name': 'Nasi Goreng',
      'category': 'Makanan',
      'price': 20000.0,
      'image': 'assets/images/prod_food.png',
    },
    {
      'id': '3',
      'name': 'Smartphone',
      'category': 'Gadget',
      'price': 2500000.0,
      'image': 'assets/images/prod_gadget.png',
    },
    {
      'id': '4',
      'name': 'Kursi Sofa',
      'category': 'Rumah',
      'price': 750000.0,
      'image': 'assets/images/prod_outfit.png',
    },
    {
      'id': '5',
      'name': 'Celana Jeans',
      'category': 'Outfit',
      'price': 120000.0,
      'image': 'assets/images/prod_outfit.png',
    },
    {
      'id': '6',
      'name': 'Burger',
      'category': 'Makanan',
      'price': 25000.0,
      'image': 'assets/images/prod_food.png',
    },
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    return _products.where((p) {
      final matchSearch = _search.isEmpty ||
          p['name'].toLowerCase().contains(_search.toLowerCase());
      final matchCat =
          _selectedCategory == null || p['category'] == _selectedCategory;
      return matchSearch && matchCat;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppSearchBar(
            onSearch: (val) => setState(() => _search = val),
          ),
          const SizedBox(height: 16),
          const Text('Kategori',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.deepBlue)),
          const SizedBox(height: 12),
          CategoriesWidget(
            onCategorySelected: (cat) =>
                setState(() => _selectedCategory = cat),
            selectedCategory: _selectedCategory,
          ),
          const SizedBox(height: 20),
          const Text('Produk Terlaris',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.deepBlue)),
          const SizedBox(height: 12),
          ProductGrid(products: _filteredProducts),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
