import 'dart:math';

import 'package:a_3_salon/View/home.dart';
import 'package:flutter/material.dart';
import 'package:shake_gesture/shake_gesture.dart';

class HomeScreen extends StatefulWidget {
  final Map? data;
  final int? discount;
  const HomeScreen({super.key, this.data, this.discount});

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

  bool isDialogOpen = false;

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
              SizedBox(height: 8),
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
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(
                      imageUrl: services[index]['image']!,
                      title: services[index]['name']!,
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
                  itemCount: barbers.length,
                  itemBuilder: (context, index) {
                    return BarberCard(
                      name: barbers[index]['name']!,
                      imageUrl: barbers[index]['image']!,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ShakeGesture(
                onShake: () {
                  if (!isDialogOpen) {
                    return;
                  }

                  setState(() {
                    isDialogOpen = false;
                  });

                  var discountArray = [5, 10, 15];
                  var randomIndex = Random().nextInt(3); // 0 - 2
                  var discount = discountArray[randomIndex];

                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('You got $discount% discount!'),
                            const SizedBox(height: 15),
                            TextButton(
                              onPressed: () {
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeView(
                                              data: dataForm,
                                              discount: discount,
                                              targetIndex: 2,
                                            )));
                              },
                              child: const Text('Go to transaction'), //test dl
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Center(
                  child: OutlinedButton(
                      onPressed: () {
                        if (widget.discount != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "You already claimed the discount!")));
                          return;
                        }

                        setState(() {
                          isDialogOpen = true;
                        });

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('Shake now to get your discount!'),
                                  const SizedBox(height: 15),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        isDialogOpen = false;
                                      });
                                    },
                                    child: const Text('Back to home'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text("Shake")),
                ),
              ),
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
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
