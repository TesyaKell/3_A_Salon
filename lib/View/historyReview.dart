import 'package:a_3_salon/View/editReview.dart';
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
        Uri.parse('http://192.168.1.6:8000/api/ulasans'),
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
        Uri.parse('http://192.168.1.6:8000/api/ulasans/$reviewId'),
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
              if (direction == DismissDirection.startToEnd) {
                navigateToEditReview(review['id']);
              } else {
                deleteReview(review['id']);
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
            ),
          );
        },
      ),
    );
  }
}
