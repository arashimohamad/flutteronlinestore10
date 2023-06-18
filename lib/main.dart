import 'package:flutter/material.dart';
import 'package:flutteronlinestore10/screens/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Online Shop',
      home: HomePage(),
    );
  }
}


// Tutorial completed :
// #12 Pengenalan Flutter - Series Tutorial Toko Online Laravel 8 + Flutter
// #13 Membaca data dari API - Series Tutorial Toko Online Laravel 8 + Flutter
// #14 Halaman detail product - Series Tutorial Toko Online Laravel 8 + Flutter Part 14