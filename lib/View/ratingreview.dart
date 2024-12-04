import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a_3_salon/models/Ulasan.dart';
import 'package:a_3_salon/services/UlasanClient.dart';
import 'package:a_3_salon/View/historyReview.dart';

class RatingReviewPage extends StatefulWidget {
  final String serviceName;
  final String serviceImage;

  RatingReviewPage({required this.serviceName, required this.serviceImage});

  @override
  _RatingReviewPageState createState() => _RatingReviewPageState();
}

class _RatingReviewPageState extends State<RatingReviewPage> {
  double _rating = 0;
  TextEditingController _reviewController = TextEditingController();

  Future<void> postReview() async {
    try {
      final ulasan = Ulasan(
        id: 0, // ID biasanya dikendalikan oleh server, tidak perlu manual.
        idCustomer: 1, // Ganti dengan ID customer yang sesuai
        idPemesanan: 2002, // Ganti dengan ID pemesanan yang sesuai
        rating: _rating.toInt(),
        komentar: _reviewController.text,
        tanggalUlasan: DateTime.now().toIso8601String(),
        fotoUlasan: null, // Bisa menambahkan foto jika perlu
      );

      await UlasanClient.store(ulasan);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review posted successfully!')),
      );

      _reviewController.clear();
      setState(() {
        _rating = 0;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryReviewPage()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error posting review: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4081),
        title: Text(
          'Rating & Review',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          widget.serviceImage,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.serviceName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'How was your experience?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Rating
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        color: Colors.yellow[700],
                        size: 40,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = index + 1.0;
                        });
                      },
                    );
                  }),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Add Review',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: 'Write your review...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.all(12),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: postReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4081),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
