import 'package:flutter/material.dart';
import 'change_password_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/New_mewang_1.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Nama: John Doe', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Email: johndoe@email.com',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // Navigasi ke halaman ganti password dan tunggu hasilnya
                final newPassword = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePasswordPage()),
                );
                if (newPassword != null && newPassword.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password berhasil diubah: $newPassword')),
                  );
                }
              },
              child: const Text('Apakah Kamu Ingin Menganti Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
