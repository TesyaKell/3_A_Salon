class DetailLayananBarber {
  final String idDetailLayanan;
  final String namaBarber;
  final String kontak;
  final String foto;
  final List<Layanan> layanans;

  DetailLayananBarber({
    required this.idDetailLayanan,
    required this.namaBarber,
    required this.kontak,
    required this.foto,
    required this.layanans,
  });

  factory DetailLayananBarber.fromJson(Map<String, dynamic> json) {
    var list = json['layanans'] as List;
    List<Layanan> layananList = list.map((i) => Layanan.fromJson(i)).toList();
    return DetailLayananBarber(
      idDetailLayanan: json['id_detail_layanan'] ?? '',
      namaBarber: json['nama_barber'] ?? '',
      kontak: json['kontak'] ?? '',
      foto: json['foto'] ?? '',
      layanans: layananList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_detail_layanan': idDetailLayanan,
      'nama_barber': namaBarber,
      'kontak': kontak,
      'foto': foto,
      'layanans': layanans.map((e) => e.toJson()).toList(),
    };
  }

  String get fullPhotoUrl {
    if (foto.isEmpty) {
      return '';
    }
    const String baseUrl = 'http://10.0.2.2:8000/storage/';
    return '$baseUrl$foto';
  }
}

class Layanan {
  final String idLayanan;
  final String namaLayanan;
  final String harga;

  Layanan({
    required this.idLayanan,
    required this.namaLayanan,
    required this.harga,
  });

  factory Layanan.fromJson(Map<String, dynamic> json) {
    return Layanan(
      idLayanan: json['id_layanan'] ?? '',
      namaLayanan: json['nama_layanan'] ?? '',
      harga: json['harga'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_layanan': idLayanan,
      'nama_layanan': namaLayanan,
      'harga': harga,
    };
  }
}
