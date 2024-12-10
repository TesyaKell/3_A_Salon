import 'dart:convert';

class DetailPemesanan {
  final String idDetailPemesanan;
  final String idPemesanan;
  final String idLayanan;
  final String idBarber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Constructor
  DetailPemesanan({
    required this.idDetailPemesanan,
    required this.idPemesanan,
    required this.idLayanan,
    required this.idBarber,
    this.createdAt,
    this.updatedAt,
  });

  // Mengubah JSON menjadi objek DetailPemesanan
  factory DetailPemesanan.fromJson(Map<String, dynamic> jsonMap) {
    return DetailPemesanan(
      idDetailPemesanan: jsonMap['id_detail_pemesanan'].toString(),
      idPemesanan: jsonMap['id_pemesanan'].toString(),
      idLayanan: jsonMap['id_layanan'].toString(),
      idBarber: jsonMap['id_barber'].toString(),
      createdAt: jsonMap['created_at'] != null
          ? DateTime.parse(jsonMap['created_at'])
          : null,
      updatedAt: jsonMap['updated_at'] != null
          ? DateTime.parse(jsonMap['updated_at'])
          : null,
    );
  }

  // Mengubah objek DetailPemesanan menjadi JSON
  String toJson() {
    final Map<String, dynamic> jsonMap = {
      'id_detail_pemesanan': idDetailPemesanan,
      'id_pemesanan': idPemesanan,
      'id_layanan': idLayanan,
      'id_barber': idBarber,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
    return json.encode(jsonMap);
  }
}
