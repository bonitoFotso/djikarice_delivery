import 'package:djikarice_delivery/models/order_model.dart';
import 'package:flutter/material.dart';

class DeliveryDetailPage extends StatelessWidget {
  final Delivery delivery;

  DeliveryDetailPage({required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Details'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Status: ${delivery.status}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Package Type: ${delivery.package_type}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Pickup Address: ${delivery.pickup_address}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Delivery Address: ${delivery.delivery_address}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Scheduled Time: ${delivery.scheduled_time}', style: TextStyle(fontSize: 16)),
            if (delivery.actual_delivery_time != null)
              Column(
                children: [
                  SizedBox(height: 10),
                  Text('Actual Delivery Time: ${delivery.actual_delivery_time}', style: TextStyle(fontSize: 16)),
                ],
              ),
            if (delivery.notes != null)
              Column(
                children: [
                  SizedBox(height: 10),
                  Text('Notes: ${delivery.notes}', style: TextStyle(fontSize: 16)),
                ],
              ),
            if (delivery.package_details != null)
              Column(
                children: [
                  SizedBox(height: 10),
                  Text('Package Details: ${delivery.package_details}', style: TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
