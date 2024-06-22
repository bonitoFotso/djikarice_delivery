import 'dart:convert';
import 'package:djikarice_delivery/models/order_model.dart';
import 'package:djikarice_delivery/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; // Importez http pour effectuer des requêtes HTTP

class DeliveryProvider extends ChangeNotifier {
  List<Delivery> _deliveries = []; // Liste des livraisons

  // Méthode pour obtenir la liste des livraisons
  List<Delivery> get deliveries => [..._deliveries];

  // Méthode pour charger les livraisons depuis une source de données (exemple: API)
  Future<void> fetchDeliveries() async {
    final url = Uri.parse('$apiUrl/api/deliveries'); // Remplacez par votre URL d'API
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;
      List<Delivery> loadedDeliveries = [];
      extractedData.forEach((deliveryData) {
        loadedDeliveries.add(Delivery.fromJson(deliveryData));
      });
      _deliveries = loadedDeliveries;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // Méthode pour ajouter une nouvelle livraison
  Future<void> addDelivery(Delivery delivery) async {
    final url = Uri.parse('$apiUrl/api/deliveries'); // Remplacez par votre URL d'API
    try {
      final response = await http.post(
        url,
        body: json.encode(delivery.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      final newDelivery = Delivery.fromJson(json.decode(response.body));
      _deliveries.add(newDelivery);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // Autres méthodes pour la mise à jour et la suppression des livraisons peuvent être ajoutées ici
}
