<<<<<<< HEAD
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class contactPage extends StatefulWidget {
  const contactPage({super.key});

  @override
  State<StatefulWidget> createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        // Tambahkan SingleChildScrollView di sini
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 26,
                  ),
                  SizedBox(width: 0),
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                width: screenWidth,
                height: screenHeight * 0.14,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Call Us',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Our team is on the line\nMon - Fri * 9 - 17',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.12,
                        height: screenWidth * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.mail_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Email us',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Our team is online\nMon - Fri * 9 - 17',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.06),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Contact us in Social Media',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  socialMediaContainer(
                      screenWidth,
                      screenHeight,
                      FontAwesome.instagram_brand,
                      'Instagram',
                      '4,6K Followers * 118 Posts'),
                  const SizedBox(height: 10),
                  socialMediaContainer(
                      screenWidth,
                      screenHeight,
                      FontAwesome.whatsapp_brand,
                      'Whatsup',
                      'Available Mon - Fri * 9 - 17'),
                  const SizedBox(height: 10),
                  socialMediaContainer(
                      screenWidth,
                      screenHeight,
                      FontAwesome.facebook_brand,
                      'Facebook',
                      '3,8K Followers * 136 Posts'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialMediaContainer(double screenWidth, double screenHeight,
      IconData icon, String title, String subtitle) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Spacer(),
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue,
              child:
                  Icon(FontAwesome.upload_solid, size: 20, color: Colors.white),
            ),
=======
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';

class SalonContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon-Contact Us',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: const Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section: Call and Email Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ContactIcon(
                  icon: Icons.phone,
                  label: 'Call Us',
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                ContactIcon(
                  icon: Icons.email,
                  label: 'Email Us',
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Section: Contact Details
            Text(
              'Phone Number',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '+62 812-3456-7890',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 10),
            Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'salon@example.com',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 30),

            // Section: Social Media Icons

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Text(
                        'Follow Us',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaIcon(
                            icon: FontAwesome.instagram_brand,
                            label: 'Instagram',
                            color: Colors.purple,
                          ),
                          SizedBox(width: 20),
                          SocialMediaIcon(
                            icon: FontAwesome.whatsapp_brand,
                            label: 'WhatsApp',
                            color: Colors.green,
                          ),
                          SizedBox(width: 20),
                          SocialMediaIcon(
                            icon: Icons.facebook,
                            label: 'Facebook',
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
>>>>>>> 78a22e76e8e25226b71e67bb3d1c9a429784ec45
          ],
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

// Widget for Contact Icons
class ContactIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const ContactIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, size: 30, color: color),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

// Widget for Social Media Icons
class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const SocialMediaIcon({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, size: 25, color: color),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
>>>>>>> 78a22e76e8e25226b71e67bb3d1c9a429784ec45
