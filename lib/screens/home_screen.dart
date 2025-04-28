import 'package:flutter/material.dart';
import 'calculator_screen.dart'; // Pastikan sudah ada file ini

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Utama")),
      body: Center(
        child: Text(
          'Selamat datang di aplikasi kalkulator! Tekan tombol FAB untuk kalkulator.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      // Floating Action Button (FAB) Kalkulator Mengambang
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi ketika FAB ditekan, membuka CalculatorScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalculatorScreen()),
          );
        },
        child: Icon(Icons.calculate), // Ikon kalkulator pada FAB
        backgroundColor: Colors.blue, // Warna latar belakang FAB
        tooltip: 'Buka Kalkulator', // Tooltip untuk FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Lokasi FAB di kanan bawah
    );
  }
}
