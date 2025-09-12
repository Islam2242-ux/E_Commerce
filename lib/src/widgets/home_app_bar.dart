import 'package:flutter/material.dart';
import '../pages/notifikasi_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/logo.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Blue Sea Shop',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 2,
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => NotifikasiPage()),
            );
          },
          icon: const Icon(
            Icons.notifications_outlined,
            size: 28,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
