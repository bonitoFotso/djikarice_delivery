import 'package:djikarice_delivery/screens/auth_screen.dart';
import 'package:djikarice_delivery/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 4000), () {});
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Si l'utilisateur est connecté, allez à l'écran de profil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Si l'utilisateur n'est pas connecté, allez à l'écran d'authentification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00695C),
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'),
      ),
    );
  }
}
