import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course et Livraison à Domicile'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nos Services de Livraison à Domicile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nous offrons des services de course et de livraison à domicile pour faciliter votre quotidien. Nos agents se chargent de faire vos courses et de vous les livrer chez vous.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildServiceItem(
                    icon: Icons.shopping_cart,
                    title: 'Courses de Supermarché',
                    description: 'Nous faisons vos courses et vous les livrons rapidement.',
                  ),
                  _buildServiceItem(
                    icon: Icons.local_grocery_store,
                    title: 'Livraison de Produits Frais',
                    description: 'Livraison de produits frais directement à votre porte.',
                  ),
                  _buildServiceItem(
                    icon: Icons.delivery_dining,
                    title: 'Livraison de Repas',
                    description: 'Livraison de vos plats préférés de vos restaurants préférés.',
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
