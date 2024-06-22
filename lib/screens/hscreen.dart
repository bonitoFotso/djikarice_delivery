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
  late AuthProvider authProvider;
  
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.refreshToken();
    authProvider.loadUserInformation();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    bool isClient = authProvider.user?.isClient ?? false;
    bool isLivreur = authProvider.user?.isLivreur ?? false;
    bool isResponsable = authProvider.user?.isResponsable ?? false;

    final List<Widget> clientPages = [
      HomePage(),
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
    } else if (isClient) {
      pages = clientPages;
      navItems = clientNavItems;
    } else {
      pages = [];
      navItems = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DJIKARICE DELIVERY'),
        backgroundColor: Color(0xFF00695C),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              authProvider.loadUserInformation();
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF00695C),
        unselectedItemColor: Color.fromARGB(255, 193, 235, 230),
        selectedItemColor: Colors.amber[800],
        items: navItems,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
