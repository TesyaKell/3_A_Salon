import 'dart:math';

import 'package:a_3_salon/View/home.dart';
import 'package:flutter/material.dart';
import 'package:shake_gesture/shake_gesture.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Map? data;
  final int? discount;
  const HomeScreen({super.key, this.data, this.discount});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _fullName = '';
  final List<Map<String, String>> services = [
    {"name": "Discount", "image": "lib/images/gambar1.png"},
    {"name": "Shake", "image": "lib/images/gambar2.png"},
    {"name": "Color", "image": "lib/images/gambar4.png"},
    {"name": "Hair Color", "image": "lib/images/gambar5.png"},
  ];

  final List<Map<String, String>> barbers = [
    {"name": "Razman", "image": "lib/images/razman.jpg"},
    {"name": "Carol", "image": "lib/images/carol.jpg"},
  ];

  bool isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullName = prefs.getString('nama_customer') ?? 'Nama Tidak Ditemukan';
    });
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: const Color.fromRGBO(210, 0, 98, 1),
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
                      'Hai, $_fullName !',
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
                            const SizedBox(width: 2),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                      builder: (context) =>
                                                          HomeView(
                                                            data: dataForm,
                                                            discount: discount,
                                                            targetIndex: 2,
                                                          )));
                                            },
                                            child: const Text(
                                                'Go to transaction'), //test dl
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Text(
                                                  'Shake now to get your discount!'),
                                              const SizedBox(height: 15),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    isDialogOpen = false;
                                                  });
                                                },
                                                child:
                                                    const Text('Back to home'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.screen_rotation,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "Shake",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                child: StoryViewCarousel(items: services),
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
    this.border,
    this.padding,
  });

  final List<Map<String, String>> services;
  final double? width, height;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
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
        width: 50,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      color: Colors.black.withOpacity(0.5),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

class StoryViewCarousel extends StatefulWidget {
  final List<Map<String, String>> items;

  const StoryViewCarousel({super.key, required this.items});

  @override
  _StoryViewCarouselState createState() => _StoryViewCarouselState();
}

class _StoryViewCarouselState extends State<StoryViewCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        if (_currentPage < widget.items.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: _currentPage == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? const Color.fromRGBO(210, 0, 98, 1)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
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
              color: Colors.grey[300],
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
