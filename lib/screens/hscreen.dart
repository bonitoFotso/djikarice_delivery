import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:djikarice_delivery/home/home_page.dart';
import 'package:djikarice_delivery/livraisons/delivery_screen.dart';
import 'package:djikarice_delivery/login/login_screen.dart';
import 'package:djikarice_delivery/profile/profile_page.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),    // Remplacer HomeWidget() par HomePage()
    SearchPage(),  // Remplacer SearchWidget() par SearchPage()
    DeliveryPage(),  // Remplacer OrdersWidget() par OrdersPage()
    FavoritesPage(), // Remplacer FavoritesWidget() par FavoritesPage()
    ProfilePage(),  // Remplacer ProfileWidget() par ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loadUserInformation();
    return Scaffold(
      appBar: AppBar(
        title: const Text('DJIKARICE DELIVERY'),
        backgroundColor: const Color(0xFF00695C),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action pour les notifications
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00695C),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Recherche'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Commandes'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favoris'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profil'),
              onTap: () {
                _onItemTapped(4);
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {
                // Ajouter l'action pour les paramètres
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Aide'),
              onTap: () {
                // Ajouter l'action pour l'aide
                Navigator.pop(context); // Ferme le drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Déconnexion'),
              onTap: () {
                authProvider.logout(); // Action pour la déconnexion
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthWidget()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00695C),
        unselectedItemColor: Color(0xFF00695C),
        selectedItemColor: Colors.amber[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Commandes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Recherche'),
    );
  }
}


class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favoris'),
    );
  }
}
