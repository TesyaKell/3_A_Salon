import 'package:flutter/material.dart';
import 'package:a_3_salon/View/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SalonApp(),
    );
  }
}
