import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  final List? checkoutItems;
  final double? checkoutTotal;
  NotifikasiPage({super.key, this.checkoutItems, this.checkoutTotal});

  @override
  Widget build(BuildContext context) {
    final List<_NotifikasiItem> _notifikasiList = [
      if (checkoutItems != null && checkoutTotal != null)
        _NotifikasiItem(
          title: 'Notifikasi Belanja',
          subtitle:
              'Checkout berhasil! Total: Rp ${checkoutTotal!.toStringAsFixed(0)}',
          icon: Icons.shopping_bag_outlined,
          color: Colors.green,
        ),
      _NotifikasiItem(
        title: 'Chat Seller: Outfit Pro',
        subtitle: 'Hai, ada yang bisa kami bantu terkait pesanan Anda?',
        icon: Icons.chat_bubble_outline,
        color: Colors.blueAccent,
      ),
      _NotifikasiItem(
        title: 'Chat Seller: Food Express',
        subtitle: 'Pesanan makanan Anda sedang diproses.',
        icon: Icons.fastfood,
        color: Colors.orangeAccent,
      ),
      _NotifikasiItem(
        title: 'Notifikasi Belanja',
        subtitle: 'Checkout berhasil! Pesanan Anda sedang diproses.',
        icon: Icons.shopping_bag_outlined,
        color: Colors.green,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: ListView.builder(
        itemCount: _notifikasiList.length,
        itemBuilder: (context, index) {
          final item = _notifikasiList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item.color.withOpacity(0.2),
                child: Icon(item.icon, color: item.color),
              ),
              title: Text(item.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.subtitle),
            ),
          );
        },
      ),
    );
  }
}

class _NotifikasiItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  _NotifikasiItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
