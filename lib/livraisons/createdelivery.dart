import 'package:djikarice_delivery/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:djikarice_delivery/models/user.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class CreateDeliveryScreen extends StatefulWidget {
  @override
  _CreateDeliveryScreenState createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  final TextEditingController _pickupAddressController = TextEditingController();
  final TextEditingController _deliveryAddressController = TextEditingController();
  final TextEditingController _scheduledTimeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String _packageType = 'small'; // Défaut à 'small' comme exemple, peut être initialisé différemment selon votre logique

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final User user = authProvider.user!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une livraison'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _pickupAddressController,
              decoration: InputDecoration(labelText: 'Adresse de ramassage'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer l\'adresse de ramassage';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _deliveryAddressController,
              decoration: InputDecoration(labelText: 'Adresse de livraison'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer l\'adresse de livraison';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _packageType,
              onChanged: (value) {
                setState(() {
                  _packageType = value!;
                });
              },
              items: [
                DropdownMenuItem(child: Text('Small'), value: 'small'),
                DropdownMenuItem(child: Text('Medium'), value: 'medium'),
                DropdownMenuItem(child: Text('Large'), value: 'large'),
                DropdownMenuItem(child: Text('Fragile'), value: 'fragile'),
                DropdownMenuItem(child: Text('Heavy'), value: 'heavy'),
              ],
              decoration: InputDecoration(labelText: 'Type de paquet'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _scheduledTimeController,
              decoration: InputDecoration(labelText: 'Heure programmée (ISO format)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer l\'heure programmée';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes (optionnel)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Créer et enregistrer la livraison
                Delivery newDelivery = Delivery(
                  id: 0, // Vous pouvez définir l'ID ou le laisser vide selon votre logique
                  client: user.id, // Remplacez par l'utilisateur actuel ou le client sélectionné
                  livreur: null, // Laissez null ou définissez le livreur selon votre logique
                  status: 'pending', // Statut par défaut, peut être initialisé différemment
                  packageType: _packageType,
                  pickupAddress: _pickupAddressController.text,
                  deliveryAddress: _deliveryAddressController.text,
                  scheduledTime: DateTime.parse(_scheduledTimeController.text),
                  actualDeliveryTime: null, // Laissez null pour l'instant
                  notes: _notesController.text.isNotEmpty ? _notesController.text : null,
                  packageDetails: null, // Laissez null ou définissez selon votre logique
                  createdAt: DateTime.now(), // Date de création actuelle
                  updatedAt: DateTime.now(), // Date de mise à jour actuelle
                );

                // Utilisez newDelivery.toJson() pour envoyer les données à votre backend ou à une autre destination

                Navigator.pop(context); // Revenir à l'écran précédent après la création
              },
              child: Text('Créer la livraison'),
            ),
          ],
        ),
      ),
    );
  }
}
