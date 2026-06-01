import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/fssai_screen.dart';
import 'screens/placeholder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSSAI Services',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const FssaiScreen(),
      routes: {
        '/placeholder': (context) => const PlaceholderScreen(),
      },
    );
  }
}
