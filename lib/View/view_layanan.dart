import 'package:flutter/material.dart';
import 'package:a_3_salon/View/view_barber.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {"name": "Hair Color", "image": "lib/images/hair_color.jpg"},
    {"name": "Hair Ceratin", "image": "lib/images/hair_ceratin.jpg"},
    {"name": "Hair Cut", "image": "lib/images/hair_cut.jpg"},
    {"name": "Hair Extension", "image": "lib/images/hair_extension.jpg"},
    {"name": "Creambath", "image": "lib/images/creambath.jpg"},
    {"name": "Hair Wash + Blow", "image": "lib/images/hair_wash_blow.jpg"},
    {"name": "Hair Styling", "image": "lib/images/hair_styling.jpg"},
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
        backgroundColor: const Color(0xFF00796B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
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
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          services[index]["image"]!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(services[index]["name"]!),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Barber',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Service',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: 2, 
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          print("Selected Index: $index");
        },
      ),
    );
  }
}
