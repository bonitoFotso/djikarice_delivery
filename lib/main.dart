import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:djikarice_delivery/provider/delivery_provider.dart';
import 'package:djikarice_delivery/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  databaseFactory = databaseFactory;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DeliveryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    print(authProvider.isAuthenticated);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DJIKARICE DELIVERY',
      theme: ThemeData(
        primaryColor: const Color(0xFF00695C), // Couleur principale
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
