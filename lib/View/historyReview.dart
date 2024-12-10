import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryReviewPage extends StatefulWidget {
  @override
  _HistoryReviewPageState createState() => _HistoryReviewPageState();
}

class _HistoryReviewPageState extends State<HistoryReviewPage> {
  List<dynamic> _reviews = [];

  Future<void> fetchReviews() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/ulasans'), // URL API untuk ulasan
      );

      if (response.statusCode == 200) {
        setState(() {
          _reviews = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading reviews: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4081),
        title: Text(
          'History of Reviews',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          final review = _reviews[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['nama_layanan'] ?? 'Service Name',
                        style: GoogleFonts.lora(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rate: ${review['rating']} / 5',
                        style: GoogleFonts.lora(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    review['komentar'] ?? 'No Comment',
                    style: GoogleFonts.lora(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      review['tanggal_ulasan'] ?? '',
                      style: GoogleFonts.lora(
                        color: Colors.black,
                        fontSize: 12,
                      ),
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
