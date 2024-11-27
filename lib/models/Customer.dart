import 'dart:convert';

class Customer {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String profilePicture;

  // Constructor
  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profilePicture,
  });

  // Mengubah JSON menjadi objek Customer
  factory Customer.fromJson(String source) {
    final Map<String, dynamic> jsonMap = json.decode(source);
    return Customer(
      id: jsonMap['id'] ?? '',
      name: jsonMap['name'] ?? '',
      email: jsonMap['email'] ?? '',
      phoneNumber: jsonMap['phoneNumber'] ?? '',
      address: jsonMap['address'] ?? '',
      profilePicture: jsonMap['profilePicture'] ?? '',
    );
  }

  // Mengubah objek Customer menjadi JSON
  String toJson() {
    final Map<String, dynamic> jsonMap = {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePicture': profilePicture,
    };
    return json.encode(jsonMap);
  }
}
