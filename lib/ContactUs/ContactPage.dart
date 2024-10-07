import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';

class SalonContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon Contact Us',
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
          ],
        ),
      ),
    );
  }
}

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
