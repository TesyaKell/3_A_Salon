import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_3_salon/models/Ulasan.dart';

class UlasanClient {
  static const String baseUrl = 'http://10.0.2.2:8000/api/ulasans';

  // Menyimpan ulasan ke server
  static Future<void> store(Ulasan ulasan) async {
    final url = Uri.parse(baseUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(ulasan.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        print('Ulasan berhasil diposting');
      } else {
        throw Exception(
            'Gagal memposting ulasan. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memposting ulasan: $e');
    }
  }

  // Mengambil semua ulasan dari server
  static Future<List<Ulasan>> getAllUlasan() async {
    final url = Uri.parse(baseUrl);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        return jsonData.map((json) => Ulasan.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat ulasan. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat mengambil ulasan: $e');
    }
  }
}
