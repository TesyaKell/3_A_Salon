import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_3_salon/View/SalonBarberDetailPage.dart';
import 'package:a_3_salon/services/DetailLayananBarberClient.dart';
import '../models/DetailLayananBarber.dart';

class ContactBarbersPage extends StatefulWidget {
  @override
  _ContactBarbersPageState createState() => _ContactBarbersPageState();
}

class _ContactBarbersPageState extends State<ContactBarbersPage> {
  List<DetailLayananBarber> barbersWithDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarbersWithDetails();
  }

  Future<void> fetchBarbersWithDetails() async {
    try {
      final barbers = await DetailLayananBarberClient.fetchAll();
      setState(() {
        barbersWithDetails = barbers;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memuat data: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToBarberDetailPage(DetailLayananBarber barber) {
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
        backgroundColor: Color(0xFFFF4081),
        title: Text('Contact Barber'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : barbersWithDetails.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada barber yang ditemukan',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
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
                              child: barber.fullPhotoUrl.isNotEmpty
                                  ? Image.network(
                                      barber.fullPhotoUrl,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'lib/images/razman.jpg',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'lib/images/razman.jpg',
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              barber.namaBarber.isNotEmpty
                                  ? barber.namaBarber
                                  : 'Nama tidak tersedia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
