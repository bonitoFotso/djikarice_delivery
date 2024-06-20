class Service {
  final int? id;
  final String type;
  final String status;
  final String startLocation;
  final double distance;
  final String description;

  Service({
    this.id,
    required this.type,
    required this.status,
    required this.startLocation,
    required this.distance,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'startLocation': startLocation,
      'distance': distance,
      'description': description,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      type: map['type'],
      status: map['status'],
      startLocation: map['startLocation'],
      distance: map['distance'],
      description: map['description'],
    );
  }
}
