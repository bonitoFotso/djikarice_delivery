import 'package:djikarice_delivery/login/login_screen.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:djikarice_delivery/screens/hscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    await Future.delayed(const Duration(milliseconds: 4000), () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      print(authProvider.isAuthenticated);
      if (authProvider.isAuthenticated) {
        // Si l'utilisateur est connecté, allez à l'écran de profil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const HomeScreen()), // Remplacez par le widget de votre page d'accueil
        );
      } else {
        // Si l'utilisateur n'est pas connecté, allez à l'écran d'authentification
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const AuthWidget()), // Remplacez par le widget de votre page d'authentification
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00695C),
      body: Center(
        child: Image.asset('assets/images/splash_logo.jpeg'),
      ),
    );
  }
}
