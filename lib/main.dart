import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/theme/app_theme.dart';
import 'src/pages/login_page.dart';
import 'src/pages/root_shell.dart';
import 'src/state/auth_state.dart';
import 'src/state/cart_state.dart';
import 'src/state/chat_state.dart';
import 'src/state/orders_state.dart';
import 'src/state/theme_state.dart';
import 'src/services/mock_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MockApi.loadAssets();
  runApp(const BlueSeaApp());
}

class BlueSeaApp extends StatelessWidget {
  const BlueSeaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => CartState()),
        ChangeNotifierProvider(create: (_) => ChatState()),
        ChangeNotifierProvider(create: (_) => OrdersState()),
        ChangeNotifierProvider(create: (_) => ThemeState()),
      ],
      child: Consumer2<AuthState, ThemeState>(
        builder: (context, auth, theme, _) {
          return MaterialApp(
            title: 'Blue Sea Shop',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
            home: auth.isLoggedIn ? const RootShell() : const LoginPage(),
          );
        },
      ),
    );
  }
}