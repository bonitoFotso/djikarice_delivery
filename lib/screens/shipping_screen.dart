import 'package:flutter/material.dart';

class ShippingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Expédition Colis'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nos Services d\'Expédition',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nous offrons des services d\'expédition de colis rapides et fiables pour répondre à tous vos besoins d\'envoi, que ce soit au niveau national ou international.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildServiceItem(
                    icon: Icons.local_shipping,
                    title: 'Expédition rapide',
                    description: 'Livraison express de vos colis partout dans le monde.',
                  ),
                  _buildServiceItem(
                    icon: Icons.track_changes,
                    title: 'Suivi de colis',
                    description: 'Suivez vos colis en temps réel avec notre service de suivi.',
                  ),
                  _buildServiceItem(
                    icon: Icons.support_agent,
                    title: 'Support client 24/7',
                    description: 'Assistance clientèle disponible 24/7 pour tous vos besoins d\'expédition.',
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
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Color(0xFF00695C)),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
