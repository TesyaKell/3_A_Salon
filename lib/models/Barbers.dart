import 'dart:convert';

class Barbers {
  final String id;
  final String nama_barber;
  final String foto;
  final String kontak;

  // Constructor
  Barbers({
    required this.id,
    required this.nama_barber,
    required this.foto,
    required this.kontak,
  });

  // Mengubah JSON menjadi objek Barbers
  factory Barbers.fromJson(Map<String, dynamic> jsonMap) {
    return Barbers(
      id: jsonMap['id'].toString(),
      nama_barber: jsonMap['nama_barber'] ?? 'No Name',
      foto: jsonMap['foto'] ?? '',
      kontak: jsonMap['kontak'] ?? '',
    );
  }

  // Mengubah objek Barbers menjadi JSON
  String toJson() {
    final Map<String, dynamic> jsonMap = {
      'id': id,
      'nama_barber': nama_barber,
      'foto': foto,
      'kontak': kontak,
    };
    return json.encode(jsonMap);
  }
}
