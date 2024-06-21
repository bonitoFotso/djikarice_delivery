import 'package:flutter/material.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport de Personnes'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nos Services de Transport de Personnes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nous offrons des services de transport de personnes adaptés à vos besoins, que ce soit pour des trajets locaux ou des voyages longue distance. Nous mettons à disposition différents types de véhicules pour garantir votre confort et sécurité.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildServiceItem(
                    icon: Icons.directions_car,
                    title: 'Voitures de Luxe',
                    description: 'Voyagez avec style et confort dans nos voitures de luxe.',
                  ),
                  _buildServiceItem(
                    icon: Icons.directions_bus,
                    title: 'Bus et Minibus',
                    description: 'Transport de groupes avec nos bus et minibus.',
                  ),
                  _buildServiceItem(
                    icon: Icons.local_taxi,
                    title: 'Taxis',
                    description: 'Services de taxi disponibles 24/7 pour vos trajets rapides.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({required IconData icon, required String title, required String description}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: const Color(0xFF00695C)),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
