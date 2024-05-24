class HealthPlace {
  String? name;
  String? address;
  String? phone;
  String? website;
  String? email;
  String? description;
  String? profilePicUrl;
  String? type; // e.g., hospital, clinic, etc.

  HealthPlace({
    this.name,
    this.address,
    this.phone,
    this.website,
    this.email,
    this.description,
    this.profilePicUrl,
    this.type,
  });

  factory HealthPlace.fromMap(Map<String, dynamic> map) {
    try {
      return HealthPlace(
        name: map['name'],
        address: map['address'],
        phone: map['phone'],
        website: map['website'],
        email: map['email'],
        description: map['description'],
        profilePicUrl: map['profilePicUrl'],
        type: map['type'],
      );
    } catch (e) {
      // Error handling
      print('Error parsing HealthPlace from map: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    try {
      return {
        'name': name,
        'address': address,
        'phone': phone,
        'website': website,
        'email': email,
        'description': description,
        'profilePicUrl': profilePicUrl,
        'type': type,
      };
    } catch (e) {
      // Error handling
      print('Error converting HealthPlace to map: $e');
      rethrow;
    }
  }
}
