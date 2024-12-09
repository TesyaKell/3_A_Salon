import 'dart:convert';
import 'dart:math';
import 'package:a_3_salon/models/Barbers.dart';
import 'package:a_3_salon/models/Layanan.dart';
import 'package:flutter/material.dart';
import 'package:a_3_salon/View/pemesanan_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetailReservationPage extends StatelessWidget {
  final Map? data;
  final List<Barbers>? dataBarber;
  final List<Layanan>? dataLayanan;
  final Map? dataReservasi;
  final int? discount;

  const DetailReservationPage(
      {Key? key,
      this.data,
      this.dataBarber,
      this.dataLayanan,
      this.dataReservasi,
      this.discount});

  @override
  Widget build(BuildContext context) {
    String customerName = dataReservasi?['fullName'] ?? 'N/A';
    String rawDate = dataReservasi?['date'] ?? 'N/A';
    String time = dataReservasi?['time'] ?? 'N/A';
    // String barberName = dataBarber?['barberName'] ?? 'N/A';
    // String serviceName = dataLayanan?['layananName'] ?? 'N/A';
    // int servicePrice = dataLayanan?['layananPrice'] ?? 0;

    // Parsing date
    DateTime parsedDate;
    try {
      parsedDate = DateFormat('dd/MM/yyyy').parse(rawDate); // Sesuaikan format
    } catch (e) {
      parsedDate = DateTime.now(); // Default jika parsing gagal
      print("Error parsing date: $e");
    }
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    int servicePrice = 0;

    for (var i = 0; i < dataLayanan!.length; i++) {
      final layanan = dataLayanan![i];

      servicePrice += layanan.harga;
    }

    // Hitung diskon dan total
    double discountPrice = servicePrice.toDouble();
    if (discount! > 0) {
      discountPrice -= discountPrice * (discount!.toDouble() / 100);
    }
    double tax = servicePrice * 0.035;
    double total = discountPrice + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservation Details',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Name
            _buildInfoContainer("Customer Name", customerName),
            SizedBox(height: 10),
            // Date & Time
            _buildInfoContainer("Date & Time", "$rawDate | $time"),
            SizedBox(height: 20),
            Text(
              "${min(dataBarber!.length, dataLayanan!.length)} service",
              style:
                  GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Service Info
            _buildServiceInfo(dataBarber!, dataLayanan!),
            Spacer(),
            // QR Code
            _buildQRCode(),
            Spacer(),
            Divider(),
            // Price Details
            _buildDetailRow(
                "Subtotal", "IDR${servicePrice.toStringAsFixed(0)},00"),
            if (discount != 0)
              _buildDetailRow("Discount $discount%",
                  "IDR${servicePrice - discountPrice},00"),
            _buildDetailRow("Tax", "IDR${tax.toStringAsFixed(0)},00"),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.lora(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "IDR${total.toStringAsFixed(0)},00",
                    style: GoogleFonts.lora(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Book Reservation Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final String url = 'http://192.168.1.17:8000/api/pemesanan';

                  final headers = {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                  };

                  final layananId = [];
                  final barberId = [];

                  for (var i = 0; i < dataLayanan!.length; i++) {
                    layananId.add(dataLayanan![i].id);
                    barberId.add(dataBarber![i].id);
                  }

                  final body = json.encode({
                    'tanggal_pemesanan':
                        formattedDate, // Tanggal yang diparsing
                    'waktu_pemesanan': dataReservasi?['time'],
                    'total_harga': total,
                    'id_customer': data!['data']['id_customer'].toString(),
                    'nama_pemesan': dataReservasi?['fullName'],
                    'status_pemesanan': 'Selesai',
                    'diskon': discount,
                    'tax': tax,
                    'layanan_ids': layananId,
                    'barber_ids': barberId
                  });

                  try {
                    final response = await http.post(Uri.parse(url),
                        headers: headers, body: body);

                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    if (response.statusCode == 201) {
                      Fluttertoast.showToast(
                        msg: "Reservation Successful",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: const Color.fromARGB(255, 51, 122, 54),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      // // Navigator to ReceiptPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiptPage(
                            data: data!,
                            dataReservasi: dataReservasi?.map((key, value) =>
                                MapEntry(key.toString(), value.toString())),
                            dataBarber: dataBarber!,
                            dataLayanan: dataLayanan!,
                            discount: discount ?? 0,
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    print('Error: $e');
                    Fluttertoast.showToast(msg: "Error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 40),
                ),
                child: Text(
                  'Book Reservation',
                  style: GoogleFonts.lora(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.lora(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceInfo(
      List<Barbers> listBarbers, List<Layanan> listLayanan) {
    final length = min(listBarbers.length, listLayanan.length);
    return Expanded(
        flex: 6,
        child: ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              final barber = listBarbers[index];
              final layanan = listLayanan[index];

              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Text(
                        barber.nama_barber[0],
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          barber.nama_barber,
                          style: GoogleFonts.lora(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(layanan.nama_layanan,
                            style: GoogleFonts.lora(fontSize: 14)),
                        Text("${layanan.waktu} Mins",
                            style: GoogleFonts.lora(
                                fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    Spacer(),
                    Text("IDR${layanan.harga.toStringAsFixed(0)},00",
                        style: GoogleFonts.lora(fontSize: 14)),
                  ],
                ),
              );
            }));
  }

  Widget _buildQRCode() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('lib/images/qr.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Scan this QR to Payment",
            style: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.lora(fontSize: 14)),
          Text(value, style: GoogleFonts.lora(fontSize: 14)),
        ],
      ),
    );
  }
}
