
// Classe de base pour l'utilisateur
class User {
  final int id;
  final String email;
  final String name;
  final bool isActive;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isClient;
  final bool isLivreur;
  final bool isResponsable;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.isActive,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
    this.isClient = false,
    this.isLivreur = false,
    this.isResponsable = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      isActive: json['active'],
      isAdmin: json['admin'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isClient: json['is_client'] ?? false,
      isLivreur: json['is_livreur'] ?? false,
      isResponsable: json['is_responsable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'active': isActive,
      'admin': isAdmin,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_client': isClient,
      'is_livreur': isLivreur,
      'is_responsable': isResponsable,
    };
  }
}


// Classe pour le responsable
class Responsable {
  final int id;
  final int user;
  final String department;
  final String role;
  final String? phoneNumber;
  final String? officeAddress;
  final DateTime? employmentDate;
  final String? managerialLevel;
  final String? permissions;
  final Map<String, dynamic>? performanceMetrics;

  Responsable({
    required this.id,
    required this.user,
    required this.department,
    required this.role,
    this.phoneNumber,
    this.officeAddress,
    this.employmentDate,
    this.managerialLevel,
    this.permissions,
    this.performanceMetrics,
  });

  factory Responsable.fromJson(Map<String, dynamic> json) {
    return Responsable(
      id: json['id'],
      user: json['user'],
      department: json['department'],
      role: json['role'],
      phoneNumber: json['phone_number'],
      officeAddress: json['office_address'],
      employmentDate: json['employment_date'] != null
          ? DateTime.parse(json['employment_date'])
          : null,
      managerialLevel: json['managerial_level'],
      permissions: json['permissions'],
      performanceMetrics: json['performance_metrics'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'department': department,
      'role': role,
      'phone_number': phoneNumber,
      'office_address': officeAddress,
      'employment_date': employmentDate?.toIso8601String(),
      'managerial_level': managerialLevel,
      'permissions': permissions,
      'performance_metrics': performanceMetrics,
    };
  }
}

// Classe pour le client
class Client {
  final int id;
  final int user;
  final String? phoneNumber;
  final String? address;
  final String? preferredPaymentMethod;
  final int loyaltyPoints;

  Client({
    required this.id,
    required this.user,
    this.phoneNumber,
    this.address,
    this.preferredPaymentMethod,
    required this.loyaltyPoints,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      user: json['user'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      preferredPaymentMethod: json['preferred_payment_method'],
      loyaltyPoints: json['loyalty_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'phone_number': phoneNumber,
      'address': address,
      'preferred_payment_method': preferredPaymentMethod,
      'loyalty_points': loyaltyPoints,
    };
  }
}

// Classe pour le livreur
class Livreur {
  final int id;
  final int user;
  final String? phoneNumber;
  final String? address;
  final String? vehicleType;
  final String? licensePlate;
  final bool availabilityStatus;
  final String? currentLocation;

  Livreur({
    required this.id,
    required this.user,
    this.phoneNumber,
    this.address,
    this.vehicleType,
    this.licensePlate,
    required this.availabilityStatus,
    this.currentLocation,
  });

  factory Livreur.fromJson(Map<String, dynamic> json) {
    return Livreur(
      id: json['id'],
      user: json['user'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      vehicleType: json['vehicle_type'],
      licensePlate: json['license_plate'],
      availabilityStatus: json['availability_status'],
      currentLocation: json['current_location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'phone_number': phoneNumber,
      'address': address,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'availability_status': availabilityStatus,
      'current_location': currentLocation,
    };
  }
}
