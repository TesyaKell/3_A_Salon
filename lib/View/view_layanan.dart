import 'package:a_3_salon/models/Barbers.dart';
import 'package:flutter/material.dart';
import 'package:a_3_salon/View/view_barber.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Layanan.dart';

class ServicesPage extends StatefulWidget {
  final Map? data;
  final List<Layanan> listLayanan;
  final List<Barbers> listBarbers;
  final int? discount;

  const ServicesPage(
      {Key? key,
      this.data,
      required this.listLayanan,
      required this.listBarbers,
      this.discount})
      : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Layanan> layananList = []; //INI UNTUK SIMPAN DATA DARI DB

  bool isLoading = true;

  // Function to fetch layanan from API
  Future<void> fetchLayanan() async {
    try {
      final response = await http
          .get(Uri.parse('https://api-tubes-pbp.vercel.app/api/api/layanan'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          layananList = data.map((item) => Layanan.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load layanan');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching layanan: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLayanan();
  }

  @override
  Widget build(BuildContext context) {
    List<Layanan> listLayanan =
        widget.listLayanan; // Untuk simpan banyak layanan
    List<Barbers> listBarbers =
        widget.listBarbers; // Untuk simpan banyak Barbers

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: listLayanan.isNotEmpty,
        title: Text(
          'Services',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: layananList.length,
                itemBuilder: (context, index) {
                  final layanan = layananList[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to BarberPage with selected layanan
                      listLayanan.add(layanan);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarberPage(
                            data: widget.data,
                            dataLayanan: listLayanan,
                            listBarbers: listBarbers,
                            discount: widget.discount,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              'lib/images/${layanan.foto}',
                              fit: BoxFit.cover,
                              height: 100,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              layanan.nama_layanan,
                              style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFC2185B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                              'IDR${layanan.harga}',
                              style: GoogleFonts.lora(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
