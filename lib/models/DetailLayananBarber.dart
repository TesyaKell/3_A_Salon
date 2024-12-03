class DetailLayananBarber {
  final String idDetailLayanan;
  final String namaBarber;
  final String namaLayanan;
  final String kontak;
  final String foto;

  DetailLayananBarber({
    required this.idDetailLayanan,
    required this.namaBarber,
    required this.namaLayanan,
    required this.kontak,
    required this.foto,
  });

  factory DetailLayananBarber.fromJson(Map<String, dynamic> json) {
    return DetailLayananBarber(
      idDetailLayanan: json['id_detail_layanan'] ?? '',
      namaBarber: json['nama_barber'] ?? '',
      namaLayanan: json['nama_layanan'] ?? '',
      kontak: json['kontak'] ?? '',
      foto: json['foto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_detail_layanan': idDetailLayanan,
      'nama_barber': namaBarber,
      'nama_layanan': namaLayanan,
      'kontak': kontak,
      'foto': foto,
    };
  }
}
