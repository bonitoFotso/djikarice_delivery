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
            SizedBox(height: 20),
            //ListTile(
            //  leading: Icon(Icons.phone, color: Color(0xFF00695C)),
            //  title: Text(user.phoneNumber),
            //),
            ListTile(
              leading: Icon(Icons.email, color: Color(0xFF00695C)),
              title: Text(user.email),
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Color(0xFF00695C)),
              title: Text('Changer le mot de passe'),
              onTap: () {
                // Action pour changer le mot de passe
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: Color(0xFF00695C)),
              title: Text('Historique des commandes'),
              onTap: () {
                // Action pour voir l'historique des commandes
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF00695C)),
              title: Text('Paramètres'),
              onTap: () {
                // Action pour les paramètres
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Color(0xFF00695C)),
              title: Text('Notifications'),
              onTap: () {
                // Action pour les notifications
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFF00695C)),
              title: Text('Déconnexion'),
              onTap: () {
                authProvider.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
