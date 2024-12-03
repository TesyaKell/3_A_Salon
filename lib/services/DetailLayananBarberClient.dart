import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/DetailLayananBarber.dart';

class DetailLayananBarberClient {
  static final String _baseUrl = '192.168.1.4';
  static final String _endpoint = '/api/detail_layanans';

  //buat ambil detail layanan
  static Future<List<DetailLayananBarber>> fetchAll() async {
    try {
      final response = await http.get(Uri.http(_baseUrl, _endpoint));
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable data = json.decode(response.body);
      return data.map((e) => DetailLayananBarber.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
