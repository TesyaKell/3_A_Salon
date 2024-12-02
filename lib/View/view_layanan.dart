import 'package:flutter/material.dart';
import 'package:a_3_salon/View/view_barber.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendDataToApi(Map<String, dynamic> layanan) async {
  final String url = 'http://10.0.2.2:8000';
  final String endpoint = '/api/layanan';

  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  try {
    final response = await http.post(
      Uri.parse('$url$endpoint'),
      headers: headers,
      body: json.encode({
        'nama_layanan': layanan['layananName'],
        'harga': layanan['layananPrice'].toString(),
      }),
    );

    if (response.statusCode == 201) {
      print('Data berhasil disimpan: ${response.body}');
    } else {
      print('Gagal menyimpan data: ${response.body}');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      "name": "Hair Color",
      "image": "lib/images/hair_color.jpg",
      "price": "IDR1.500.000,00",
      "priceInt": "1500000"
    },
    {
      "name": "Hair Ceratin",
      "image": "lib/images/hair_ceratin.jpg",
      "price": "IDR200.000,00",
      "priceInt": "200000"
    },
    {
      "name": "Hair Cut",
      "image": "lib/images/hair_cut.jpg",
      "price": "IDR150.000,00",
      "priceInt": "150000"
    },
    {
      "name": "Hair Extension",
      "image": "lib/images/hair_extension.jpg",
      "price": "IDR5.000.000,00",
      "priceInt": "5000000"
    },
    {
      "name": "Creambath",
      "image": "lib/images/creambath.jpg",
      "price": "IDR100.000,00",
      "priceInt": "100000"
    },
    {
      "name": "Hair Wash + Blow",
      "image": "lib/images/hair_wash_blow.jpg",
      "price": "IDR70.000,00",
      "priceInt": "70000"
    },
    {
      "name": "Hair Styling",
      "image": "lib/images/hair_styling.jpg",
      "price": "IDR100.000,00",
      "priceInt": "100000"
    },
  ];

  final Map? data;
  final int? discount;

  ServicesPage({Key? key, this.data, this.discount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Map<String, dynamic> formData = {};
                formData['layananName'] = services[index]["name"]!;
                formData['layananPrice'] = services[index]["priceInt"]!;

                sendDataToApi(formData);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BarberPage(
                          data: data,
                          dataLayanan: formData,
                          discount: discount)),
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
                        services[index]["image"]!,
                        fit: BoxFit.cover,
                        height: 100,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        services[index]["name"]!,
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC2185B),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Center(
                      child: Text(
                        services[index]["price"]!,
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
