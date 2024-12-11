import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:a_3_salon/View/ratingreview.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailHistoryPage extends StatefulWidget {
  final int idPemesanan;
  final int idCustomer;

  const DetailHistoryPage(
      {Key? key, required this.idPemesanan, required this.idCustomer})
      : super(key: key);

  @override
  _DetailHistoryPageState createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  bool isLoading = true;
  Map<String, dynamic> pemesananDetail = {};
  Map<String, dynamic> layananDetail = {};
  Map<String, dynamic> barberDetail = {};
  List<Map<String, dynamic>> pemesanans = [];

  Future<void> fetchPemesanans() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api-tubes-pbp.vercel.app/api/api/detail_pemesanan'));

      print(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        List<dynamic> pemesanansList = responseData['data'];

        // Filter data berdasarkan id_pemesanan
        final detail = pemesanansList.firstWhere(
          (item) => item['pemesanans']['id_pemesanan'] == widget.idPemesanan,
          orElse: () => null,
        );

        if (detail != null) {
          setState(() {
            pemesananDetail = detail['pemesanans'] ?? {};
            layananDetail = detail['layanans'] ?? {};
            barberDetail = detail['barbers'] ?? {};

            isLoading = false;
          });
        } else {
          // Jika tidak ditemukan, tampilkan pesan error
          setState(() {
            isLoading = false;
          });
          print('Pemesanan dengan ID ${widget.idPemesanan} tidak ditemukan');
        }
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
        title: Text(
          'History Detail',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailColumn(
                            "Date",
                            _parseToString(
                                pemesananDetail['tanggal_pemesanan'])),
                        _buildDetailColumn("Start Time",
                            _parseToString(pemesananDetail['waktu_pemesanan'])),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDetailColumn(
                          " ",
                          (layananDetail['nama_layanan'] ?? 'N/A') +
                              " - " +
                              (barberDetail['nama_barber'] ?? 'N/A'),
                        ),
                        _buildDetailColumn(
                          " ",
                          "IDR ${layananDetail['harga'] ?? 'N/A'}",
                        ),
                      ],
                    ),
                    Divider(height: 40, color: Colors.grey),
                    Center(
                      child: Text(
                        "Service",
                        style: GoogleFonts.lora(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildDashedLine(),
                    _buildServiceRow(layananDetail['nama_layanan'] ?? 'N/A',
                        _parseToString(layananDetail['harga'])),
                    _buildDashedLine(),
                    _buildServiceRow(
                        "Sub Total", _parseToString(layananDetail['harga'])),
                    _buildServiceRow(
                        "Tax", _parseToDouble(layananDetail['harga']) * 0.08),
                    Divider(height: 40, color: Colors.grey),
                    _buildServiceRow(
                        "Total", _parseToDouble(layananDetail['harga']) * 1.08,
                        isBold: true),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('lib/images/qr.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Scan this QR code at the salon for\nquick check-in.',
                            style: GoogleFonts.lora(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RatingReviewPage(
                                serviceName:
                                    layananDetail['nama_layanan'] ?? 'N/A',
                                serviceImage:
                                    'lib/images/${layananDetail['foto']}' ??
                                        'lib/images/hair_cut.jpg',
                                idPemesanan: widget.idPemesanan,
                                idCustomer: widget.idCustomer,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Add Rating and Review',
                          style: GoogleFonts.lora(
                            color: Colors.pinkAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.lora(fontSize: 14, color: Colors.grey)),
        Text(
          value,
          style: GoogleFonts.lora(
            fontSize: 14,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceRow(String label, dynamic value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lora(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            "IDR ${_parseToString(value)}",
            style: GoogleFonts.lora(
              fontSize: 14,
              color: Colors.pink,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: List.generate(
          100,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.grey,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }

  String _parseToString(dynamic value) {
    return value?.toString() ?? 'N/A';
  }

  int _parseToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    }
    return 0;
  }

  double _parseToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    }
    return 0.0;
  }
}
