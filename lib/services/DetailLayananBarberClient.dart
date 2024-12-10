import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/DetailLayananBarber.dart';

class DetailLayananBarberClient {
  //buat ambil detail layanan
  static Future<List<DetailLayananBarber>> fetchAll() async {
    try {
      final response =
          await http.get(Uri.http('10.0.2.2:8000', '/api/detail_layanans'));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable data = json.decode(response.body);
      return data.map((e) => DetailLayananBarber.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
