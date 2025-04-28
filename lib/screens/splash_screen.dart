import 'package:flutter/material.dart';
import 'menu_screen.dart'; // pastikan file ini sudah dibuat dan berada di lib/screens/

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MenuScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/logounesa.png', // <- PERUBAHAN ADA DI SINI
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
