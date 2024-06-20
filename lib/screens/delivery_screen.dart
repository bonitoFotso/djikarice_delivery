import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course et Livraison à Domicile'),
        backgroundColor: const Color(0xFF00695C),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'Courses de Supermarché':
                  _showServiceDetails(
                    context,
                    'Courses de Supermarché',
                    'Nous faisons vos courses et vous les livrons rapidement.',
                    Icons.shopping_cart,
                  );
                  break;
                case 'Livraison de Produits Frais':
                  _showServiceDetails(
                    context,
                    'Livraison de Produits Frais',
                    'Livraison de produits frais directement à votre porte.',
                    Icons.local_grocery_store,
                  );
                  break;
                case 'Livraison de Repas':
                  _showServiceDetails(
                    context,
                    'Livraison de Repas',
                    'Livraison de vos plats préférés de vos restaurants préférés.',
                    Icons.delivery_dining,
                  );
                  break;
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Courses de Supermarché',
                  child: Text('Courses de Supermarché'),
                ),
                const PopupMenuItem<String>(
                  value: 'Livraison de Produits Frais',
                  child: Text('Livraison de Produits Frais'),
                ),
                const PopupMenuItem<String>(
                  value: 'Livraison de Repas',
                  child: Text('Livraison de Repas'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nos Services de Livraison à Domicile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nous offrons des services de course et de livraison à domicile pour faciliter votre quotidien. Nos agents se chargent de faire vos courses et de vous les livrer chez vous.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: Center(
                child: Text(
                  'Sélectionnez un service dans le menu déroulant.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceDetails(
      BuildContext context, String title, String description, IconData icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: const Color(0xFF00695C)),
              const SizedBox(height: 16),
              Text(description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}
