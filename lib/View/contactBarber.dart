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
  List<dynamic> barbersWithDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBarbersWithDetails();
  }

  Future<void> fetchBarbersWithDetails() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.17:8000/api/detail_layanans'));
      if (response.statusCode == 200) {
        setState(() {
          barbersWithDetails = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load barbers with details');
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
              itemCount: barbersWithDetails.length,
              itemBuilder: (context, index) {
                final barber = barbersWithDetails[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://192.168.1.17:8000/storage/${barber['barber']['foto']}',
                    ),
                  ),
                  title: Text(barber['barber']['nama_barber']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kontak: ${barber['barber']['kontak']}'),
                      SizedBox(height: 4),
                      Text('Layanan:'),
                      ...barber['layanans'].map<Widget>((layanan) {
                        return Text(
                            '• ${layanan['nama_layanan']} - Rp${layanan['harga']}');
                      }).toList(),
                    ],
                  ),
                  trailing:
                      Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                  onTap: () {
                    _launchWhatsApp(barber['barber']['kontak']);
                  },
                );
              },
            ),
    );
  }
}
