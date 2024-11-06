import 'package:flutter/material.dart';
import 'package:a_3_salon/View/view_barber.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      "name": "Hair Color",
      "image": "lib/images/hair_color.jpg",
      "price": "IDR1.500.000,00"
    },
    {
      "name": "Hair Ceratin",
      "image": "lib/images/hair_ceratin.jpg",
      "price": "IDR200.000,00"
    },
    {
      "name": "Hair Cut",
      "image": "lib/images/hair_cut.jpg",
      "price": "IDR150.000,00"
    },
    {
      "name": "Hair Extension",
      "image": "lib/images/hair_extension.jpg",
      "price": "IDR5.000.000,00"
    },
    {
      "name": "Creambath",
      "image": "lib/images/creambath.jpg",
      "price": "IDR100.000,00"
    },
    {
      "name": "Hair Wash + Blow",
      "image": "lib/images/hair_wash_blow.jpg",
      "price": "IDR70.000,00"
    },
    {
      "name": "Hair Styling",
      "image": "lib/images/hair_styling.jpg",
      "price": "IDR100.000,00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services',
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
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.9, // Adjusted for shorter cards
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarberPage()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        services[index]["image"]!,
                        fit: BoxFit.cover,
                        height: 100, // Reduced height for a more compact look
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0), // Adjusted padding
                      child: Text(
                        services[index]["name"]!,
                        style: TextStyle(
                          fontSize: 15, // Slightly smaller font
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      services[index]["price"]!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
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
