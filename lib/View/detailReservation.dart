import 'package:flutter/material.dart';

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
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
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
            _buildDetailRow("Customer Name", customerName),
            SizedBox(height: 10),
            _buildDetailRow("Date & Time", "$time | $date"),
            SizedBox(height: 20),
            Text(
              "1 service",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Text(
                          barberName[0],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barberName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(serviceName, style: TextStyle(fontSize: 14)),
                          Text("60 Mins",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      Spacer(),
                      Text("IDR${servicePrice.toStringAsFixed(0)},00"),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "IDR${total.toStringAsFixed(0)},00",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking reservation action
                  print("Reservation confirmed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 40),
                  child: Text(
                    'Book Reservation',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
