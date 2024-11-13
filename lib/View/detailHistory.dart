import 'package:flutter/material.dart';
import 'package:a_3_salon/View/ratingreview.dart';

class DetailReservationPage extends StatelessWidget {
  final Map? data;
  final Map? dataBarber;
  final Map? dataLayanan;
  final Map? dataReservasi;

  const DetailReservationPage({
    Key? key,
    this.data,
    this.dataBarber,
    this.dataLayanan,
    this.dataReservasi,
  });

  @override
  Widget build(BuildContext context) {
    String date = dataReservasi?['date'] ?? 'N/A';
    String time = dataReservasi?['time'] ?? 'N/A';
    String barberName = dataBarber?['barberName'] ?? 'N/A';
    String serviceName = dataLayanan?['layananName'] ?? 'N/A';
    int servicePrice = int.parse(dataLayanan?['layananPrice'] ?? '0');
    double tax = servicePrice * 0.08;
    double total = servicePrice + tax;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History Detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailColumn("Date", date),
                  _buildDetailColumn("Start Time", time),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailColumn("Barber", barberName),
                  _buildDetailColumn("Duration", "60 Mins"),
                ],
              ),
              Divider(height: 40, color: Colors.grey),
              Center(
                child: Text(
                  "Service",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              _buildDashedLine(),
              _buildServiceRow(serviceName, servicePrice),
              _buildDashedLine(),
              _buildServiceRow("Sub Total", servicePrice),
              _buildServiceRow("Tax", tax.toInt()),
              Divider(height: 40, color: Colors.grey),
              _buildServiceRow("Total", total.toInt(), isBold: true),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/images/qr.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Scan this QR code at the salon for\nquick check-in.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RatingReviewPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Add Rating and Review',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceRow(String label, int value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            "IDR${value.toStringAsFixed(0)},00",
            style: TextStyle(
              fontSize: 14,
              color: Colors.pink,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: List.generate(
          100,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.grey,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
