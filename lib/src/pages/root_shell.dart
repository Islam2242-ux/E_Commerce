import 'package:badges/badges.dart' as badges;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';
import '../theme/app_theme.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'account_page.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;
  final _pages = const [HomePage(), CartPage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartState>().totalCount;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        height: 60,
        color: Colors.white,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppTheme.lightBlue,
        items: <Widget>[
          const Icon(Icons.home, size: 26, color: AppTheme.deepBlue),
          badges.Badge(
            showBadge: cartCount > 0,
            badgeContent: Text('$cartCount', style: const TextStyle(color: Colors.white)),
            child: const Icon(Icons.shopping_cart_outlined, size: 26, color: AppTheme.deepBlue),
          ),
          const Icon(Icons.person_outline, size: 26, color: AppTheme.deepBlue),
        ],
        onTap: (i) => setState(() => _index = i),
      ),
      body: _pages[_index],
    );
  }
}