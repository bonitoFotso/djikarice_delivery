import 'dart:convert';

class Delivery {
  final int? id;
  final int? client; // Référence au client
  final int? livreur; // Référence au livreur
  final String? status;
  final String? package_type;
  final String? pickup_address;
  final String? delivery_address;
  final DateTime? scheduled_time;
  final DateTime? actual_delivery_time; // Date/heure réelle de la livraison (optionnel)
  final String? notes; // Notes (optionnel)
  final String? package_details; // Détails du paquet en JSON (optionnel)
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Delivery({
    this.id,
    this.client,
    this.livreur,
    this.status,
    this.package_type,
    this.pickup_address,
    this.delivery_address,
    this.scheduled_time,
    this.actual_delivery_time,
    this.notes,
    this.package_details,
    this.createdAt,
    this.updatedAt,
  });

  // Méthode pour convertir un Delivery en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client': client,
      'livreur': livreur,
      'status': status,
      'package_type': package_type,
      'pickup_address': pickup_address,
      'delivery_address': delivery_address,
      'scheduled_time': scheduled_time?.toIso8601String(),
      'actual_delivery_time': actual_delivery_time?.toIso8601String(),
      'notes': notes,
      'package_details': package_details,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Méthode pour créer un Delivery à partir d'un JSON
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      client: json['client'],
      livreur: json['livreur'],
      status: json['status'],
      package_type: json['package_type'],
      pickup_address: json['pickup_address'],
      delivery_address: json['delivery_address'],
      scheduled_time: DateTime.parse(json['scheduled_time']),
      actual_delivery_time: json['actual_delivery_time'] != null ? DateTime.parse(json['actual_delivery_time']) : null,
      notes: json['notes'],
      package_details: json['package_details'] != null ? jsonEncode(json['package_details']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
