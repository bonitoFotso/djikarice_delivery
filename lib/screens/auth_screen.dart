import 'package:djikarice_delivery/livraisons/createdelivery.dart';
import 'package:djikarice_delivery/screens/drawer/home_drawer.dart';
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
  late Future<void> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _loadUserFuture = authProvider.loadUserInformation();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DJIKARICE DELIVERY'),
        backgroundColor: Color(0xFF00695C),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              setState(() {
                _loadUserFuture = authProvider.loadUserInformation();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!authProvider.isAuthenticated || authProvider.user == null) {
            return Center(child: Text('Utilisateur non trouvé ou non authentifié'));
          } else {
            bool isClient = authProvider.user?.isClient ?? false;
            bool isLivreur = authProvider.user?.isLivreur ?? false;
            bool isResponsable = authProvider.user?.isResponsable ?? false;

            final List<Widget> clientPages = [
              CreateDeliveryScreen(),
              HistoryPage(),
              ProfilePage(),
            ];

            final List<Widget> livreurPages = [
              HomePage(),
              CreateDeliveryScreen(),
              DeliveryPage(),
              ProfilePage(),
            ];

            final List<Widget> responsablePages = [
              HomePage(),
              CreateDeliveryScreen(),
              DeliveryPage(),
              HistoryPage(),
              ProfilePage(),
            ];

            final List<BottomNavigationBarItem> clientNavItems = [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favoris',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ];

            final List<BottomNavigationBarItem> livreurNavItems = [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Delivery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Commandes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ];

            final List<BottomNavigationBarItem> responsableNavItems = [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Delivery',
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
            ];

            List<Widget> pages;
            List<BottomNavigationBarItem> navItems;

            if (isResponsable) {
              pages = responsablePages;
              navItems = responsableNavItems;
            } else if (isLivreur) {
              pages = livreurPages;
              navItems = livreurNavItems;
            } else {
              pages = clientPages;
              navItems = clientNavItems;
            }

            return Scaffold(
              body: IndexedStack(
                index: _currentIndex,
                children: pages,
              ),
              
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color(0xFF00695C),
                selectedItemColor: Colors.amber[800],
                items: navItems,
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
              ),
            );
          }
        },
      ),
      drawer: CustomDrawer(
                onItemTapped: _onItemTapped,
                onLogout: () {
                  authProvider.logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AuthWidget()),
                  );
                },
              ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favoris'),
    );
  }
}

class LivreurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Livreur Page'),
    );
  }
}

class ResponsablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Responsable Page'),
    );
  }
}
