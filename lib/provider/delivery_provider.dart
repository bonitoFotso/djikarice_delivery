import 'dart:convert';
import 'package:djikarice_delivery/helpers/database_helper.dart';
import 'package:djikarice_delivery/models/order_model.dart';
import 'package:djikarice_delivery/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DeliveryProvider extends ChangeNotifier {
  String? _token;

  List<Delivery> _deliveries = [];
  late Delivery d;

  // Getter pour obtenir la liste des livraisons
  List<Delivery> get deliveries => [..._deliveries];

  // Méthode pour charger les livraisons depuis une source de données (ex: API)
  Future<void> fetchDeliveries() async {
    final url = Uri.parse('$apiUrl/api/deliveries');
    await _loadToken();
    if (_token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load deliveries');
      }
      print(response.body);

      final extractedData = json.decode(response.body) as List<dynamic>;
      List<Delivery> loadedDeliveries = [];
      for (var deliveryData in extractedData) {
        loadedDeliveries.add(Delivery.fromJson(deliveryData));
      }
      _deliveries = loadedDeliveries;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // Méthode pour charger le token depuis la base de données
  Future<void> _loadToken() async {
    _token = await DatabaseHelper().getToken();
    notifyListeners();
  }

  // Méthode pour ajouter une nouvelle livraison
  Future<void> addDelivery(Delivery delivery) async {
    final url = Uri.parse('$apiUrl/api/deliveries/');
    print(json.encode(delivery.toJson()));
    await _loadToken();
    if (_token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.post(
        url,
        body: json.encode(delivery.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      print(response.body);

      if (response.statusCode != 201) {
        throw Exception('Failed to add delivery');
      }

      final newDelivery = Delivery.fromJson(json.decode(response.body));
      _deliveries.add(newDelivery);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  // Autres méthodes pour la mise à jour et la suppression des livraisons peuvent être ajoutées ici
}
