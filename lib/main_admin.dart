import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/theme/app_theme.dart';
import 'src/state/orders_state.dart';
import 'src/state/theme_state.dart';
import 'src/services/mock_api.dart';
import 'src/pages/admin_orders_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MockApi.loadAssets();
  runApp(const BlueSeaAdminApp());
}

class BlueSeaAdminApp extends StatelessWidget {
  const BlueSeaAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrdersState()),
        ChangeNotifierProvider(create: (_) => ThemeState()),
      ],
      child: Consumer<ThemeState>(builder: (context, theme, _) {
        return MaterialApp(
          title: 'Blue Sea Admin',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const AdminLoginPage(),
        );
      }),
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;
  void _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _loading = false);
    if (_email.text.trim() == 'admin@shop.com' && _pass.text == 'admin123') {
      if (context.mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AdminOrdersPage()));
    } else {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Creds admin salah.')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth:520), child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: _email, decoration: const InputDecoration(hintText: 'Email')),
        const SizedBox(height: 12),
        TextField(controller: _pass, decoration: const InputDecoration(hintText: 'Password'), obscureText: true),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: _loading?null:_login, child: _loading?const CircularProgressIndicator():const Text('Login as Admin')))
      ])))),
    );
  }
}