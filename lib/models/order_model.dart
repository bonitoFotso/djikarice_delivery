
class Delivery {
  final int id;
  final int client; // Référence au client
  final int? livreur; // Référence au livreur
  final String status;
  final String packageType;
  final String pickupAddress;
  final String deliveryAddress;
  final DateTime scheduledTime;
  final DateTime? actualDeliveryTime; // Date/heure réelle de la livraison (optionnel)
  final String? notes; // Notes (optionnel)
  final Map<String, dynamic>? packageDetails; // Détails du paquet en JSON (optionnel)
  final DateTime createdAt;
  final DateTime updatedAt;

  Delivery({
    required this.id,
    required this.client,
    this.livreur,
    required this.status,
    required this.packageType,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.scheduledTime,
    this.actualDeliveryTime,
    this.notes,
    this.packageDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  // Méthode pour convertir un Delivery en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client': client,
      'livreur': livreur,
      'status': status,
      'packageType': packageType,
      'pickupAddress': pickupAddress,
      'deliveryAddress': deliveryAddress,
      'scheduledTime': scheduledTime.toIso8601String(),
      'actualDeliveryTime': actualDeliveryTime?.toIso8601String(),
      'notes': notes,
      'packageDetails': packageDetails,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Méthode pour créer un Delivery à partir d'un JSON
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      client: json['client'],
      livreur: json['livreur'],
      status: json['status'],
      packageType: json['packageType'],
      pickupAddress: json['pickupAddress'],
      deliveryAddress: json['deliveryAddress'],
      scheduledTime: DateTime.parse(json['scheduledTime']),
      actualDeliveryTime: json['actualDeliveryTime'] != null ? DateTime.parse(json['actualDeliveryTime']) : null,
      notes: json['notes'],
      packageDetails: json['packageDetails'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
