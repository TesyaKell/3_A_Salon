import 'dart:convert';

class Layanan {
  final String id;
  final String nama_layanan;
  final int harga;
  final int waktu;
  final String foto;

  // Constructor
  Layanan({
    required this.id,
    required this.nama_layanan,
    required this.harga,
    required this.waktu,
    required this.foto,
  });

  // Mengubah JSON menjadi objek Layanan
  factory Layanan.fromJson(Map<String, dynamic> jsonMap) {
    return Layanan(
      id: jsonMap['id'].toString(),
      nama_layanan: jsonMap['nama_layanan'] ?? 'No Name',
      harga: jsonMap['harga'] ?? 0,
      waktu: jsonMap['waktu'] ?? 0,
      foto: jsonMap['foto'] ?? '',
    );
  }

  // Mengubah objek Layanan menjadi JSON
  String toJson() {
    final Map<String, dynamic> jsonMap = {
      'id': id,
      'nama_layanan': nama_layanan,
      'harga': harga,
      'waktu': waktu,
      'foto': foto,
    };
    return json.encode(jsonMap);
  }
}
