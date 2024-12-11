import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditReviewPage extends StatefulWidget {
  final int reviewId;

  EditReviewPage({required this.reviewId});

  @override
  _EditReviewPageState createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  late Map<String, dynamic> _reviewData;
  bool isLoading = true;
  final _komentarController = TextEditingController();
  int _rating = 1;

  @override
  void initState() {
    super.initState();
    fetchReviewData();
  }

  // Fungsi untuk mengambil data ulasan berdasarkan reviewId
  Future<void> fetchReviewData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api-tubes-pbp.vercel.app/api/api/ulasans/get/${widget.reviewId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _reviewData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load review');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching review data: $error')),
      );
    }
  }

  // Fungsi untuk memperbarui ulasan
  Future<void> updateReview() async {
    try {
      final response = await http.put(
        Uri.parse(
            'https://api-tubes-pbp.vercel.app/api/api/ulasans/${widget.reviewId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'komentar': _komentarController.text,
          'rating': _rating,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Review updated successfully')),
        );
        Navigator.pop(context);
      } else {
        throw Exception('Failed to update review');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating review: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Review'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _komentarController,
                    decoration: InputDecoration(labelText: 'Komentar'),
                    onChanged: (value) {
                      setState(() {
                        _reviewData['komentar'] = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Rating:'),
                      Slider(
                        value: _rating.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: _rating.toString(),
                        onChanged: (value) {
                          setState(() {
                            _rating = value.toInt();
                          });
                        },
                      ),
                      Text('$_rating / 5'),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: updateReview,
                    child: Text('Update Review'),
                  ),
                ],
              ),
            ),
    );
  }
}
