import 'package:djikarice_delivery/models/order_model.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:djikarice_delivery/provider/delivery_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class DeliveryFormPage extends StatefulWidget {
  const DeliveryFormPage({super.key});

  @override
  _DeliveryFormPageState createState() => _DeliveryFormPageState();
}

class _DeliveryFormPageState extends State<DeliveryFormPage> {
  final _formKey = GlobalKey<FormState>();
  late int client;
  int? livreur;
  late String status = 'pending';
  String packageType = 'small';
  late String pickupAddress;
  late String deliveryAddress;
  late DateTime scheduledTime;
  String? notes;
  late DateTime createdAt;
  late DateTime updatedAt;

  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  final List<DropdownMenuItem<String>> packageTypeChoices = [
    const DropdownMenuItem(value: 'small', child: Text('Small')),
    const DropdownMenuItem(value: 'medium', child: Text('Medium')),
    const DropdownMenuItem(value: 'large', child: Text('Large')),
    const DropdownMenuItem(value: 'fragile', child: Text('Fragile')),
    const DropdownMenuItem(value: 'heavy', child: Text('Heavy')),
  ];
  final List<DropdownMenuItem<String>> statusChoices = [
    const DropdownMenuItem(value: 'pending', child: Text('Pending')),
    const DropdownMenuItem(value: 'in_transit', child: Text('In Transit')),
    const DropdownMenuItem(value: 'delivered', child: Text('Delivered')),
    const DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
  ];

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    client = authProvider.client?.id ?? 0;
    pickupAddress = authProvider.client?.address ?? '';
    status = 'pending';
    packageType = 'small';
    deliveryAddress = '4ttrte';
    scheduledTime = DateTime.now();
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryProvider = Provider.of<DeliveryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une livraison'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
             DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type de paquet'),
                items: packageTypeChoices,
                value: packageType, // Définir la valeur par défaut ici
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le type de paquet';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    packageType = value!;
                  });
                },
                onSaved: (value) {
                  packageType = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adresse de ramassage'),
                initialValue: pickupAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse de ramassage';
                  }
                  return null;
                },
                onSaved: (value) {
                  pickupAddress = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adresse de livraison'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse de livraison';
                  }
                  return null;
                },
                onSaved: (value) {
                  deliveryAddress = value!;
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Heure programmée'),
                subtitle: Text(formatDateTime(scheduledTime)),
                trailing: Icon(Icons.calendar_today, color: Colors.grey),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: scheduledTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(scheduledTime),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        scheduledTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes (optionnel)'),
                onSaved: (value) {
                  notes = value!.isNotEmpty ? value : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var newDelivery = Delivery(
                      id: 0,
                      client: client,
                      //livreur: livreur,
                      status: status,
                      package_type: packageType,
                      pickup_address: pickupAddress,
                      delivery_address: deliveryAddress,
                      scheduled_time: scheduledTime,
                      actual_delivery_time: null,
                      notes: notes,
                      package_details: null,
                      createdAt: createdAt,
                      updatedAt: updatedAt,
                    );
                    await deliveryProvider.addDelivery(newDelivery);
                    print(newDelivery.toJson());

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Livraison créée avec succès!')),
                    );

                    _formKey.currentState!.reset();
                  }
                },
                child: const Text('Créer la livraison'),
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
