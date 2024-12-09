import 'dart:convert';

class Ulasan {
  final int? id;
  final int idCustomer;
  final int idPemesanan;
  final int rating;
  final String komentar;
  final String tanggalUlasan;
  final String? fotoUlasan;

  Ulasan({
    this.id,
    required this.idCustomer,
    required this.idPemesanan,
    required this.rating,
    required this.komentar,
    required this.tanggalUlasan,
    this.fotoUlasan,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) {
    return Ulasan(
      id: json['id_ulasan'] as int?,
      idCustomer: json['id_customer'] as int,
      idPemesanan: json['id_pemesanan'] as int,
      rating: json['rating'] as int,
      komentar: json['komentar'] ?? '',
      tanggalUlasan: json['tanggal_ulasan'] as String,
      fotoUlasan: json['foto_ulasan'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_customer': idCustomer,
      'id_pemesanan': idPemesanan,
      'rating': rating,
      'komentar': komentar,
      'tanggal_ulasan': tanggalUlasan,
      'foto_ulasan': fotoUlasan ?? '',
    };
  }
}
