import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:a_3_salon/View/detailHistory.dart';

void main() {
  runApp(SalonHistoryApp());
}

class SalonHistoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.loraTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
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
            children: [
              Card(
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
                        'Oct 11, 2024 - 17:45',
                        style: GoogleFonts.lora(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'lib/images/hair_cut.jpg',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hair cut',
                                  style: GoogleFonts.lora(fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Status : Completed',
                                  style: GoogleFonts.lora(fontSize: 14),
                                ),
                                Text(
                                  'Barbers: Abell',
                                  style: GoogleFonts.lora(fontSize: 14),
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
                                builder: (context) => DetailReservationPage(
                                  dataReservasi: {
                                    'date': 'Oct 11, 2024',
                                    'time': '17:45',
                                  },
                                  dataBarber: {
                                    'barberName': 'Abel',
                                  },
                                  dataLayanan: {
                                    'layananName': 'Hair cut',
                                    'layananPrice': '150000',
                                  },
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'View Detail',
                            style: GoogleFonts.lora(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
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
