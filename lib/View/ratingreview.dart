import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a_3_salon/models/Ulasan.dart';
import 'package:a_3_salon/services/UlasanClient.dart';
import 'package:a_3_salon/View/historyReview.dart';

class RatingReviewPage extends StatefulWidget {
  final String serviceName;
  final String serviceImage;
  final int idPemesanan;
  final int idCustomer;

  RatingReviewPage({
    required this.serviceName,
    required this.serviceImage,
    required this.idPemesanan,
    required this.idCustomer,
  });

  @override
  _RatingReviewPageState createState() => _RatingReviewPageState();
}

class _RatingReviewPageState extends State<RatingReviewPage> {
  double _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  bool isLoading = false;

  Future<void> postReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating')),
      );
      return;
    }

    if (_reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write a review')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final ulasan = Ulasan(
        idUlasan: 0,
        idCustomer: widget.idCustomer,
        idPemesanan: widget.idPemesanan,
        rating: _rating.toInt(),
        komentar: _reviewController.text,
        tanggalUlasan: DateTime.now().toIso8601String(),
      );

      await UlasanClient.store(ulasan);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review posted successfully!')),
      );

      _reviewController.clear();
      setState(() {
        _rating = 0;
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryReviewPage()),
      );
    } catch (error) {
      setState(() {
        isLoading = false;
      });
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
                        style: GoogleFonts.lora(
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
                  style: GoogleFonts.lora(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
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
                style: GoogleFonts.lora(
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
                style: GoogleFonts.lora(),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : postReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4081),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Post',
                          style: GoogleFonts.lora(fontSize: 16),
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
