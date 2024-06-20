import 'package:djikarice_delivery/screens/add_order_screen.dart';
import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/order_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Order> orders = [];
  String filter = 'Tous';

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final data = await DatabaseHelper.instance.readAllOrders();
    setState(() {
      orders = data;
    });
  }

  void _applyFilter(String selectedFilter) {
    setState(() {
      filter = selectedFilter;
    });
  }

  List<Order> get filteredOrders {
    if (filter == 'Tous') {
      return orders;
    } else if (filter == 'Par Distance') {
      return orders..sort((a, b) => a.distance.compareTo(b.distance));
    } else {
      return orders.where((order) => order.status == filter).toList();
    }
  }

  void _navigateToAddOrder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddOrderScreen()),
    );
    if (result == true) {
      _loadOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commandes et Livraisons'),
        backgroundColor: const Color(0xFF00695C),
        actions: [
          PopupMenuButton<String>(
            onSelected: _applyFilter,
            itemBuilder: (BuildContext context) {
              return ['Tous', 'En cours', 'Terminé', 'Par Distance'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          final order = filteredOrders[index];
          return ListTile(
            title: Text(order.type),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${order.status}'),
                Text('Départ: ${order.startLocation}'),
                Text('Distance: ${order.distance} km'),
                Text('Description: ${order.description}'),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddOrder,
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF00695C),
      ),
    );
  }
}
