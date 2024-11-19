import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactBarbersPage extends StatelessWidget {
  final List<Map<String, String>> barbers = [
    {
      'name': 'Abel',
      'specialty': 'Hair Extension',
      'image': 'lib/images/carol.jpg',
      'phone': '6282278313058'
    },
    {
      'name': 'Luivuitong',
      'specialty': 'Hair Color',
      'image': 'lib/images/carol.jpg',
      'phone': '6282278313058'
    },
    {
      'name': 'Vadel',
      'specialty': 'Hair Treatment',
      'image': 'lib/images/carol.jpg',
      'phone': '6282278313058'
    },
    {
      'name': 'Razman',
      'specialty': 'Hair Stylist',
      'image': 'lib/images/carol.jpg',
      'phone': '6282278313058'
    },
    {
      'name': 'Carol',
      'specialty': 'Hair Treatment',
      'image': 'lib/images/carol.jpg',
      'phone': '6282278313058'
    },
    {
      'name': 'Kak Gem',
      'specialty': 'Hair Color',
      'image': 'lib/images/carol.jpg',
      'phone': '6282278313058'
    },
  ];

  void _launchWhatsApp(String phone) async {
    final url = Uri.parse('https://wa.me/$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Barbers'),
      ),
      body: ListView.builder(
        itemCount: barbers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(barbers[index]['image']!),
            ),
            title: Text(barbers[index]['name']!),
            subtitle: Text(barbers[index]['specialty']!),
            trailing: Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
            onTap: () {
              _launchWhatsApp(barbers[index]['phone']!);
            },
          );
        },
      ),
    );
  }
}

class ContactBarbersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactBarbersPage(),
    );
  }
}
