import 'package:djikarice_delivery/screens/delivery_screen.dart';
import 'package:djikarice_delivery/screens/moving_screen.dart';
import 'package:djikarice_delivery/screens/shipping_screen.dart';
import 'package:djikarice_delivery/screens/transport_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToService(BuildContext context, String serviceName) {
    Widget serviceScreen;

    switch (serviceName) {
      case 'Course et livraison à domicile':
        serviceScreen = DeliveryScreen();
        break;
      case 'Déménagement et transport de marchandises':
        serviceScreen = MovingScreen(); // Créez ce widget
        break;
      case 'Service expédition colis':
        serviceScreen = ShippingScreen(); // Créez ce widget
        break;
      case 'Transport de personnes':
        serviceScreen = TransportScreen(); // Créez ce widget
        break;
      default:
        serviceScreen = HomeScreen();
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => serviceScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DJIKARICE DELIVERY'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildServiceCard(context, 'Course et livraison à domicile',
                Icons.local_shipping),
            _buildServiceCard(
                context,
                'Déménagement et transport de marchandises',
                Icons.move_to_inbox),
            _buildServiceCard(context, 'Service expédition colis', Icons.send),
            _buildServiceCard(
                context, 'Transport de personnes', Icons.directions_car),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () => _navigateToService(context, title),
      child: Card(
        color: const Color(0xFF00695C),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
