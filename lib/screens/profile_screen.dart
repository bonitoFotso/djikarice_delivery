import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue, ${user?.email ?? 'Utilisateur'}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Voici vos informations de profil.',
              style: TextStyle(fontSize: 16),
            ),
            // Ajoutez d'autres widgets de profil ici
          ],
        ),
      ),
    );
  }
}
