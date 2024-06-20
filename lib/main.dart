import 'package:flutter/material.dart';
import 'package:djikarice_delivery/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DJIKARICE DELIVERY',
      theme: ThemeData(
        primaryColor: Color(0xFF00695C), // Couleur principale
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
