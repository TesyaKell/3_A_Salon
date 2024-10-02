import 'package:flutter/material.dart';
import 'package:a_3_salon/View/profil.dart'; // Mengimpor ProfileView dari file yang sesuai

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileView(), // Memanggil ProfileView sebagai halaman awal
    );
  }
}
