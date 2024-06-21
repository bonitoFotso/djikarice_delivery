import 'package:djikarice_delivery/login/login_screen.dart';
import 'package:djikarice_delivery/models/user.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Charger les informations de l'utilisateur lorsque l'écran est construit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authProvider.loadUserInformation().catchError((error) {
        // Gérer les erreurs ici, par exemple afficher une boîte de dialogue d'erreur
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erreur'),
            content: Text('$error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthWidget()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bienvenue ${authProvider.user?.name ?? ''}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Profil'),
              leading: const Icon(Icons.account_circle),
              onTap: () {
                // Naviguer vers l'écran de profil
              },
            ),
            ListTile(
              title: const Text('Commandes'),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                // Naviguer vers l'écran des commandes
              },
            ),
            ListTile(
              title: const Text('Paramètres'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Naviguer vers l'écran de paramètres
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: authProvider.isAuthenticated
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenue ${authProvider.user?.name ?? ''}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  if (authProvider.user is Client)
                    const Text('Vous êtes un client'),
                  if (authProvider.user is Livreur)
                    const Text('Vous êtes un livreur'),
                  if (authProvider.user is Responsable)
                    const Text('Vous êtes un responsable'),
                ],
              )
            : const CircularProgressIndicator(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Indice de l'élément sélectionné
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Commandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          // Gérer la navigation en fonction de l'indice sélectionné
        },
      ),
    );
  }
}
