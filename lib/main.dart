import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
          Text('Redempta Rista Elvira - 247000675'),
          Text('arthi-247000676'),
          Text('Gabriella-220711884'),
          Text('Bernadeta-220711678'),
          Text('Tesya-220711896'),
          Text(' Imanuella Daniel  - 220711901'),
          ],
        ),
      ),
    );
  }
}
