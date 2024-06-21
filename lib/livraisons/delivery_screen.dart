import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Livraisons'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          DeliveryCard(
            orderId: '12345',
            status: 'En route',
            estimatedTime: '15 mins',
            deliveryPerson: 'John Doe',
            deliveryPhone: '123-456-7890',
          ),
          DeliveryCard(
            orderId: '67890',
            status: 'En préparation',
            estimatedTime: '30 mins',
            deliveryPerson: 'Jane Smith',
            deliveryPhone: '098-765-4321',
          ),
        ],
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String estimatedTime;
  final String deliveryPerson;
  final String deliveryPhone;

  DeliveryCard({
    required this.orderId,
    required this.status,
    required this.estimatedTime,
    required this.deliveryPerson,
    required this.deliveryPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Commande #: $orderId', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Statut: $status', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Temps estimé: $estimatedTime', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF00695C),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(deliveryPerson, style: TextStyle(fontSize: 16)),
              subtitle: Text('Téléphone: $deliveryPhone', style: TextStyle(fontSize: 14)),
              trailing: IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {
                  // Action pour appeler le livreur
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action pour afficher les détails complets de la commande
              },
              child: Text('Voir les détails'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00695C)),
            ),
          ],
        ),
      ),
    );
  }
}
