import 'dart:math';

import 'package:a_3_salon/View/home.dart';
import 'package:flutter/material.dart';
import 'package:shake_gesture/shake_gesture.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            color: Color(0xFFFF4081),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hai, ${dataForm?['fullName']} !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 222, 93, 136)
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Row(
                          children: [
                            Icon(
                              Icons.screen_rotation,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Shake',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
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
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    items: services
                        .map((service) => TRoundedImage(
                              services: [service],
                            ))
                        .toList(),
                    options: CarouselOptions(viewportFraction: 0.8),
                  )),
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

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.services,
    this.onPressed,
    this.width,
    this.height,
    // required this.applyImageRadius,
    this.border,
    // required this.backgroundColor,
    this.padding,
  });

  final List<Map<String, String>> services;
  final double? width, height;
  // final String imageURL;
  // final bool applyImageRadius;
  final BoxBorder? border;
  // final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  // final bool isNetWorkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            // color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            services[0]['image']!,
            fit: BoxFit.cover,
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
