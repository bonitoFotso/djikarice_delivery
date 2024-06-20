import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/order_model.dart';

class AddOrderScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addOrder(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final order = Order(
        type: _typeController.text,
        status: _statusController.text,
        startLocation: _startLocationController.text,
        distance: double.parse(_distanceController.text),
        description: _descriptionController.text,
      );
      await DatabaseHelper.instance.create(order);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter Commande'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Type de Service'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le type de service';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Statut'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le statut';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startLocationController,
                decoration: const InputDecoration(labelText: 'Lieu de Départ'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le lieu de départ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(labelText: 'Distance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la distance';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _addOrder(context),
                child: const Text('Ajouter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00695C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}