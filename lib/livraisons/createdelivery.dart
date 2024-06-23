import 'package:djikarice_delivery/livraisons/delivery_detail_page.dart';
import 'package:djikarice_delivery/livraisons/delivery_form_page.dart';
import 'package:djikarice_delivery/livraisons/delivery_history_page.dart';
import 'package:djikarice_delivery/provider/delivery_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDeliveryScreen extends StatefulWidget {
  @override
  _CreateDeliveryScreenState createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  late Future<void> _deliveriesFuture;

  @override
  void initState() {
    super.initState();
    _deliveriesFuture = _fetchDeliveries();
  }

  Future<void> _fetchDeliveries() async {
    await Provider.of<DeliveryProvider>(context, listen: false).fetchDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deliveries'),
        backgroundColor: const Color(0xFF00695C),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _deliveriesFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else {
            return Consumer<DeliveryProvider>(
              builder: (ctx, deliveryProvider, _) {
                final deliveries = deliveryProvider.deliveries.where((d) =>
                    d.status == 'pending' || d.status == 'in_transit').toList();
                return ListView.builder(
                  itemCount: deliveries.length,
                  itemBuilder: (ctx, i) {
                    final delivery = deliveries[i];
                    return ListTile(
                      title: Text('Status: ${delivery.status}'),
                      subtitle: Text(
                          'From: ${delivery.pickup_address} To: ${delivery.delivery_address}'),
                      tileColor: delivery.status == 'pending'
                          ? Colors.yellow
                          : Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryDetailPage(delivery: delivery),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeliveryFormPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: const Color(0xFF00695C),
      ),
    );
  }
}
