import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_3_salon/models/Ulasan.dart';

class UlasanClient {
  static final String baseUrl = '192.168.1.4:8000';
  static final String endpoint = '/api/ulasans';

  static Future<List<Ulasan>> fetchAll() async {
    try {
      final response = await http.get(Uri.http(baseUrl, endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body);
      return list.map((json) => Ulasan.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Ulasan> fetchById(int id) async {
    try {
      final response = await http.get(Uri.http(baseUrl, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Ulasan.fromJson(json.decode(response.body));
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> create(Ulasan ulasan) async {
    try {
      final response = await http.post(
        Uri.http(baseUrl, endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(ulasan.toJson()),
      );

      if (response.statusCode != 201) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> update(Ulasan ulasan) async {
    try {
      final response = await http.put(
        Uri.http(baseUrl, '$endpoint/${ulasan.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(ulasan.toJson()),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> delete(int id) async {
    try {
      final response = await http.delete(Uri.http(baseUrl, '$endpoint/$id'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
