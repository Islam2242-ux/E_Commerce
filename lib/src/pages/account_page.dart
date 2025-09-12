import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_page.dart';
import 'chat_list_page.dart';
import 'profile_page.dart';
import 'change_password_page.dart';
import 'notifikasi_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = [
      {'icon': Icons.person_outline, 'title': 'Profile'},
      {'icon': Icons.lock_outline, 'title': 'Change Password'},
      {'icon': Icons.notifications_none, 'title': 'Notifications'},
      {'icon': Icons.help_outline, 'title': 'Help & Support'},
    ];

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.deepBlue, AppTheme.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: AssetImage('assets/images/New_mewang_1.png'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Nama Pengguna', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('user@example.com', style: TextStyle(color: Colors.white70)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
            ...menu.map((m) => ListTile(
              leading: Icon(m['icon'] as IconData, color: AppTheme.deepBlue),
              title: Text(m['title'] as String),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
              if ((m['title'] as String) == 'Profile') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfilePage()));
              } else if ((m['title'] as String) == 'Change Password') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChangePasswordPage()));
              } else if ((m['title'] as String) == 'Notifications') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => NotifikasiPage()));
              } else if ((m['title'] as String) == 'Help & Support') {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChatListPage()));
              }
              },
            )),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout'),
            onTap: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Konfirmasi'),
                  content: const Text('Apakah Anda yakin ingin logout?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
                    ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Logout')),
                  ],
                ),
              );
              if (ok == true && context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout Successful')));
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}