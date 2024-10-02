import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Map? data;
  const HomeScreen({super.key, this.data});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> services = [
    {"name": "Hair Cut", "image": "lib/images/hair_cut.jpg"},
    {"name": "Hair Color", "image": "lib/images/hair_color.jpg"},
    {"name": "Creambath", "image": "lib/images/creambath.jpg"},
    {"name": "Keratin", "image": "lib/images/hair_ceratin.jpg"},
  ];

  final List<Map<String, String>> barbers = [
    {"name": "Razman", "image": "lib/images/razman.jpg"},
    {"name": "Carol", "image": "lib/images/carol.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFF508C9B),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hai, ${dataForm?['fullName']} !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8), // spacing
              Text(
                'Treatment apa hari ini?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Service Favorites:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Menggunakan ListView untuk menampilkan layanan favorit secara horizontal
              SizedBox(
                height: 150, // Tinggi ListView
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Scroll ke arah horizontal
                  itemCount: services.length, // Jumlah item dlm services
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      imageUrl: services[index]
                          ['image']!, // Mengambil URL gambar
                      title: services[index]['name']!, // Mengambil nama layanan
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Popular Barbers:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: barbers.length, // Jumlah item dalam barbers
                  itemBuilder: (context, index) {
                    return BarberCard(
                      name: barbers[index]['name']!, // Mengambil nama barber
                      imageUrl: barbers[index]
                          ['image']!, // Mengambil URL gambar
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const ReviewCard(
                name: 'Tesya Rakhel',
                review:
                    'Potongan rambutnya sangat rapi dan bagus sekali, sesuai dengan permintaan saya. Terima kasih...',
                rating: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ServiceCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0), // Margin horizontal
      child: Container(
        width: 150, // Lebar tetap
        child: Column(
          children: [
            Container(
              height: 100, // Tinggi gambar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover, // Mengisi kontainer
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class BarberCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const BarberCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Menggunakan Container untuk gambar
          Container(
            width: 60, // Lebar gambar
            height: 60, // Tinggi gambar
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8.0), // Jika ingin sudut membulat
              image: DecorationImage(
                image: AssetImage(imageUrl), // Menggunakan AssetImage
                fit: BoxFit.cover, // Memastikan gambar mengisi area
              ),
            ),
          ),
          const SizedBox(width: 10), // Jarak antara gambar dan teks
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String review;
  final int rating;

  const ReviewCard({
    super.key,
    required this.name,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Rate: $rating/5'),
              ],
            ),
            const SizedBox(height: 10),
            Text(review),
          ],
        ),
      ),
    );
  }
}
