import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/calc_screen.dart';

void main() => runApp(const ProviderScope(child: TechCalcApp()));

class TechCalcApp extends StatelessWidget {
  const TechCalcApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TechCalc',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004D40), brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const TechCalcScreen(),
  );
}
