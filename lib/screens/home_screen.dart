import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  void _navigateToService(BuildContext context, String serviceName) {
    // Remplacez cette fonction avec une navigation vers les écrans de services spécifiques
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to $serviceName')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DJIKARICE DELIVERY'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildServiceCard(context, 'Course et livraison à domicile', Icons.local_shipping),
            _buildServiceCard(context, 'Déménagement et transport de marchandises', Icons.move_to_inbox),
            _buildServiceCard(context, 'Service expédition colis', Icons.send),
            _buildServiceCard(context, 'Transport de personnes', Icons.directions_car),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () => _navigateToService(context, title),
      child: Card(
        color: Color(0xFF00695C),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
