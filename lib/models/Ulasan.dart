import 'dart:convert';

class Ulasan {
  final int? idUlasan;
  final int idCustomer;
  final int idPemesanan;
  final int rating;
  final String komentar;
  final String tanggalUlasan;

  Ulasan({
    this.idUlasan,
    required this.idCustomer,
    required this.idPemesanan,
    required this.rating,
    required this.komentar,
    required this.tanggalUlasan,
  });

  factory Ulasan.fromJson(Map<String, dynamic> json) {
    return Ulasan(
      idUlasan: json['id_ulasan'] as int?,
      idCustomer: json['id_customer'] as int,
      idPemesanan: json['id_pemesanan'] as int,
      rating: json['rating'] as int,
      komentar: json['komentar'] ?? '',
      tanggalUlasan: json['tanggal_ulasan'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_ulasan': idUlasan,
      'id_customer': idCustomer,
      'id_pemesanan': idPemesanan,
      'rating': rating,
      'komentar': komentar,
      'tanggal_ulasan': tanggalUlasan,
    };
  }
}
