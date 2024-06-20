import 'package:flutter/material.dart';
import 'package:djikarice_delivery/screens/home.dart'; // Remplacez par votre widget d'écran d'accueil

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'home',)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00695C), // Utilisation de la couleur principale
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'),
      ),
    );
  }
}
