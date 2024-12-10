import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_3_salon/View/SalonBarberDetailPage.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactBarbersPage extends StatefulWidget {
  @override
  _ContactBarbersPageState createState() => _ContactBarbersPageState();
}

class _ContactBarbersPageState extends State<ContactBarbersPage> {
  List<dynamic> barbersWithDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarbersWithDetails();
  }

  Future<void> fetchBarbersWithDetails() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:8000/api/detail_layanans'));
      if (response.statusCode == 200) {
        setState(() {
          barbersWithDetails = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load barbers');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateToBarberDetailPage(dynamic barber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SalonBarberDetailPage(barber: barber),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
        title: Text(
          'Contact Barbers',
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: barbersWithDetails.length,
              itemBuilder: (context, index) {
                final barber = barbersWithDetails[index];
                return GestureDetector(
                  onTap: () => _navigateToBarberDetailPage(barber),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: barber['foto'] != null
                              ? Image(
                                  image: AssetImage(
                                      'lib/images/${barber['foto']}'),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/default_image.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          barber['nama_barber'] ?? 'Nama tidak tersedia',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lora(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lora',
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
