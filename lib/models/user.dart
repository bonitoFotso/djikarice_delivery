
// Classe de base pour l'utilisateur
class User {
  final int id;
  final String email;
  final String name;
  final bool isActive;
  final bool isAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.isActive,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      isActive: json['is_active'],
      isAdmin: json['is_admin'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'is_active': isActive,
      'is_admin': isAdmin,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Classe pour le profil utilisateur
class UserProfile {
  final User user;
  final String? phoneNumber;
  final String? address;
  final String? preferredPaymentMethod;
  final int loyaltyPoints;
  final String role;

  UserProfile({
    required this.user,
    this.phoneNumber,
    this.address,
    this.preferredPaymentMethod,
    required this.loyaltyPoints,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      user: User.fromJson(json['user']),
      phoneNumber: json['phone_number'],
      address: json['address'],
      preferredPaymentMethod: json['preferred_payment_method'],
      loyaltyPoints: json['loyalty_points'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'phone_number': phoneNumber,
      'address': address,
      'preferred_payment_method': preferredPaymentMethod,
      'loyalty_points': loyaltyPoints,
      'role': role,
    };
  }
}

// Classe pour le responsable
class Responsable {
  final User user;
  final String department;
  final String role;
  final String? phoneNumber;
  final String? officeAddress;
  final DateTime? employmentDate;
  final String? managerialLevel;
  final String? permissions;
  final Map<String, dynamic>? performanceMetrics;

  Responsable({
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
      user: User.fromJson(json['user']),
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
      'user': user.toJson(),
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
  final User user;
  final String? phoneNumber;
  final String? address;
  final String? preferredPaymentMethod;
  final int loyaltyPoints;

  Client({
    required this.user,
    this.phoneNumber,
    this.address,
    this.preferredPaymentMethod,
    required this.loyaltyPoints,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      user: User.fromJson(json['user']),
      phoneNumber: json['phone_number'],
      address: json['address'],
      preferredPaymentMethod: json['preferred_payment_method'],
      loyaltyPoints: json['loyalty_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'phone_number': phoneNumber,
      'address': address,
      'preferred_payment_method': preferredPaymentMethod,
      'loyalty_points': loyaltyPoints,
    };
  }
}

// Classe pour le livreur
class Livreur {
  final User user;
  final String? phoneNumber;
  final String? address;
  final String? vehicleType;
  final String? licensePlate;
  final bool availabilityStatus;
  final String? currentLocation;

  Livreur({
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
      user: User.fromJson(json['user']),
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
      'user': user.toJson(),
      'phone_number': phoneNumber,
      'address': address,
      'vehicle_type': vehicleType,
      'license_plate': licensePlate,
      'availability_status': availabilityStatus,
      'current_location': currentLocation,
    };
  }
}
