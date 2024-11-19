import 'package:flutter/material.dart';
import 'package:a_3_salon/View/pemesanan_pdf.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailReservationPage extends StatelessWidget {
  final Map? data;
  final Map? dataBarber;
  final Map? dataLayanan;
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
    String date = dataReservasi?['date'] ?? 'N/A';
    String time = dataReservasi?['time'] ?? 'N/A';
    String barberName = dataBarber?['barberName'] ?? 'N/A';
    String serviceName = dataLayanan?['layananName'] ?? 'N/A';
    int servicePrice = int.parse(dataLayanan?['layananPrice']);
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Name",
                    style: GoogleFonts.lora(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "$customerName",
                    style: GoogleFonts.lora(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date & Time",
                    style: GoogleFonts.lora(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "$date | $time",
                    style: GoogleFonts.lora(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "1 service",
              style:
                  GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.zero,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          barberName[0],
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
                            barberName,
                            style: GoogleFonts.lora(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(serviceName,
                              style: GoogleFonts.lora(fontSize: 14)),
                          Text("60 Mins",
                              style: GoogleFonts.lora(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Spacer(),
                      Text("IDR${servicePrice.toStringAsFixed(0)},00",
                          style: GoogleFonts.lora(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
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
                    'Scan this qr to payment',
                    style: GoogleFonts.lora(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(),
            _buildDetailRow(
                "Subtotal", "IDR${servicePrice.toStringAsFixed(0)},00"),
            discount != 0
                ? _buildDetailRow("Discount $discount%",
                    "IDR${servicePrice - discountPrice},00")
                : Container(),
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReceiptPage(
                        dataReservasi: dataReservasi?.map(
                            (key, value) => MapEntry(key, value.toString())),
                        dataBarber: dataBarber?.map(
                            (key, value) => MapEntry(key, value.toString())),
                        dataLayanan: dataLayanan?.map(
                            (key, value) => MapEntry(key, value.toString())),
                        discount: discount ?? 0,
                      ),
                    ),
                  );
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: GoogleFonts.lora(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
