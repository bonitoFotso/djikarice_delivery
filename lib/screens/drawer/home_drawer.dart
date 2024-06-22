import 'package:flutter/material.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onItemTapped;
  final VoidCallback onLogout;

  const CustomDrawer({
    Key? key,
    required this.onItemTapped,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF00695C),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu ${authProvider.user?.name ?? ''}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  authProvider.user?.email ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (authProvider.user?.isClient ?? false)
                  const Text(
                    'Client',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                else if (authProvider.user?.isLivreur ?? false)
                  const Text(
                    'Livreur',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                else if (authProvider.user?.isResponsable ?? false)
                  const Text(
                    'Responsable',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () {
              onItemTapped(0);
              Navigator.pop(context); // Ferme le drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Recherche'),
            onTap: () {
              onItemTapped(1);
              Navigator.pop(context); // Ferme le drawer
            },
          ),
          if (authProvider.user?.isClient ?? false) ...[
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Commandes'),
              onTap: () {
                onItemTapped(2);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favoris'),
              onTap: () {
                onItemTapped(3);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
          ],
          if (authProvider.user?.isLivreur ?? false) ...[
            ListTile(
              leading: const Icon(Icons.delivery_dining),
              title: const Text('Livraisons'),
              onTap: () {
                onItemTapped(5); // Ajustez l'index si nécessaire
                Navigator.pop(context); // Ferme le drawer
              },
            ),
          ],
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profil'),
            onTap: () {
              onItemTapped(4);
              Navigator.pop(context); // Ferme le drawer
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Paramètres'),
            onTap: () {
              // Ajouter l'action pour les paramètres
              Navigator.pop(context); // Ferme le drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Aide'),
            onTap: () {
              // Ajouter l'action pour l'aide
              Navigator.pop(context); // Ferme le drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Déconnexion'),
            onTap: () {
              onLogout(); // Action pour la déconnexion
            },
          ),
        ],
      ),
    );
  }
}
