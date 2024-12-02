import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactBarbersPage extends StatefulWidget {
  @override
  _ContactBarbersPageState createState() => _ContactBarbersPageState();
}

class _ContactBarbersPageState extends State<ContactBarbersPage> {
  List<dynamic> barbers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    tampilBarber();
  }

  Future<void> tampilBarber() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.17:8000/api/barbers'));
      if (response.statusCode == 200) {
        setState(() {
          barbers = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load barbers');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: barbers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://192.168.1.17:8000/storage/${barbers[index]['foto']}',
                    ),
                  ),
                  title: Text(barbers[index]['nama_barber']),
                  subtitle: Text(barbers[index]['kontak']),
                  trailing:
                      Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  onTap: () {
                    _launchWhatsApp(barbers[index]['kontak']);
                  },
                );
              },
            ),
    );
  }
}
