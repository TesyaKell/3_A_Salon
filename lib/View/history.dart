import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:a_3_salon/View/detailHistory.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> pemesanans = [];

  Future<int?> getCurrentCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id_customer');
  }

  Future<void> fetchPemesanans() async {
    try {
      final int? customerId = await getCurrentCustomerId();

      if (customerId == null) {
        throw Exception('Customer ID not found');
      }

      final response = await http.get(
        Uri.parse(
            'https://api-tubes-pbp.vercel.app/api/api/detail_pemesanan/$customerId'),
      );

      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        List<dynamic> pemesanansList = responseData['data'];

        setState(() {
          pemesanans = pemesanansList
              .map((item) => item as Map<String, dynamic>)
              .toList();

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load pemesanans');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching pemesanans: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPemesanans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4081),
        title: Text(
          'History',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pemesanans.length,
              itemBuilder: (context, index) {
                final detail_pemesanan = pemesanans[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${detail_pemesanan['pemesanans']['tanggal_pemesanan']} - ${detail_pemesanan['pemesanans']['waktu_pemesanan']}',
                          style: GoogleFonts.lora(
                              color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: detail_pemesanan['layanans']['foto'] !=
                                          null &&
                                      detail_pemesanan['layanans']['foto']
                                          .isNotEmpty
                                  ? Image.asset(
                                      'lib/images/${detail_pemesanan['layanans']['foto']}',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pemesanan ke-${index + 1}',
                                    style: GoogleFonts.lora(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Status: ${detail_pemesanan['pemesanans']['status_pemesanan']}',
                                    style: GoogleFonts.lora(fontSize: 14),
                                  ),
                                  Text(
                                    'Nama Pemesan: ${detail_pemesanan['pemesanans']['nama_pemesan']}',
                                    style: GoogleFonts.lora(fontSize: 14),
                                  ),
                                  Text(
                                    'Layanan: ${detail_pemesanan['layanans']['nama_layanan']}',
                                    style: GoogleFonts.lora(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailHistoryPage(
                                      idPemesanan:
                                          detail_pemesanan['pemesanans']
                                              ['id_pemesanan'],
                                      idCustomer: detail_pemesanan['pemesanans']
                                          ['id_customer']),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                              foregroundColor: Colors.white,
                            ),
                            child:
                                Text('View Detail', style: GoogleFonts.lora()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
