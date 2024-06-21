import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    print(authProvider.user);
    final user = authProvider.user;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF00695C),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher des produits...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              Text(
              user!.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              user.email,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            
          ],
        ),
      ),
    );
  }
}
