import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppSearchBar extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  const AppSearchBar({super.key, this.onSearch});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        hintText: 'Cari produk...',
        prefixIcon: Icon(Icons.search, color: AppTheme.deepBlue),
      ),
      onChanged: widget.onSearch,
    );
  }
}
