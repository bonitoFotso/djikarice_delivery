import 'package:djikarice_delivery/livraisons/delivery_detail_page.dart';
import 'package:djikarice_delivery/provider/delivery_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryHistoryScreen extends StatefulWidget {
  @override
  _DeliveryHistoryScreenState createState() => _DeliveryHistoryScreenState();
}

class _DeliveryHistoryScreenState extends State<DeliveryHistoryScreen> {
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
        title: Text('Delivery History'),
        backgroundColor: const Color(0xFF00695C),
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
                    d.status == 'delivered' || d.status == 'cancelled').toList();
                return ListView.builder(
                  itemCount: deliveries.length,
                  itemBuilder: (ctx, i) {
                    final delivery = deliveries[i];
                    return ListTile(
                      title: Text('Status: ${delivery.status}'),
                      subtitle: Text(
                          'From: ${delivery.pickup_address} To: ${delivery.delivery_address}'),
                      tileColor: delivery.status == 'delivered'
                          ? Colors.green
                          : Colors.red,
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
    );
  }
}
