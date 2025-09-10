import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoriesWidget extends StatelessWidget {
  final ValueChanged<String?>? onCategorySelected;
  final String? selectedCategory;
  const CategoriesWidget(
      {super.key, this.onCategorySelected, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final cats = [
      {'name': 'None', 'icon': Icons.clear},
      {'name': 'Outfit', 'icon': Icons.checkroom},
      {'name': 'Makanan', 'icon': Icons.fastfood},
      {'name': 'Gadget', 'icon': Icons.devices_other},
      {'name': 'Rumah', 'icon': Icons.chair_outlined},
    ];
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final c = cats[i];
          final isSelected =
              (c['name'] == 'None' && selectedCategory == null) ||
                  (selectedCategory == c['name']);
          return GestureDetector(
            onTap: () {
              if (c['name'] == 'None') {
                onCategorySelected?.call(null);
              } else {
                onCategorySelected?.call(c['name'] as String);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.deepBlue : Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ],
              ),
              child: Row(
                children: [
                  Icon(c['icon'] as IconData,
                      color: isSelected ? Colors.white : AppTheme.deepBlue),
                  const SizedBox(width: 8),
                  Text(
                    c['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: cats.length,
      ),
    );
  }
}
