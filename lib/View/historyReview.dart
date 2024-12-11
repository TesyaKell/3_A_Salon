import 'package:a_3_salon/View/editReview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HistoryReviewPage extends StatefulWidget {
  @override
  _HistoryReviewPageState createState() => _HistoryReviewPageState();
}

class _HistoryReviewPageState extends State<HistoryReviewPage> {
  List<dynamic> _reviews = [];

  Future<int?> getCurrentCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id_customer');
  }

  Future<void> fetchReviews() async {
    try {
      final int? customerId = await getCurrentCustomerId();

      if (customerId == null) {
        throw Exception('Customer ID not found');
      }

      final response = await http.get(
        Uri.parse(
            'https://api-tubes-pbp.vercel.app/api/api/ulasans/${customerId}'),
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

  Future<void> deleteReview(int reviewId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://api-tubes-pbp.vercel.app/api/api/ulasans/$reviewId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _reviews.removeWhere((review) => review['id_ulasan'] == reviewId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Review deleted successfully')),
        );
      } else {
        throw Exception('Failed to delete review');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting review: $error')),
      );
    }
  }

  Future<void> navigateToEditReview(int reviewId) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReviewPage(reviewId: reviewId),
      ),
    );
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

          return Dismissible(
            key: Key(review['id'].toString()), // Unique key for each review
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                navigateToEditReview(review['id_ulasan']);
              } else {
                deleteReview(review['id_ulasan']);
              }
            },
            child: Padding(
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
                          review['pemesanan']['detail_pemesanan'][0]['layanans']
                                  ['nama_layanan'] ??
                              'Service Name',
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
            ),
          );
        },
      ),
    );
  }
}
