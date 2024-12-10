import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_3_salon/models/Ulasan.dart';

class UlasanClient {
  static const String baseUrl = 'http://10.53.8.26:8000/api/ulasans';
  static Future<void> store(Ulasan ulasan) async {
    final url = Uri.parse(baseUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(ulasan.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Review posted successfully');
      } else {
        throw Exception('Failed to post review');
      }
    } catch (e) {
      throw Exception('Error posting review: $e');
    }
  }

  // Mengambil semua ulasan dari server
  static Future<List<Ulasan>> getAllUlasan() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((json) => Ulasan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
