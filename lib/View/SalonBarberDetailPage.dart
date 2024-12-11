import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SalonBarberDetailPage extends StatelessWidget {
  final dynamic barber;

  const SalonBarberDetailPage({Key? key, required this.barber})
      : super(key: key);

  void _launchWhatsApp(String phoneNumber) async {
    final whatsappUrl = 'https://wa.me/$phoneNumber';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Tidak dapat membuka WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          barber['nama_barber'] ?? 'Detail Barber',
          style: GoogleFonts.lora(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: barber['foto'] != null
                        ? AssetImage('lib/images/${barber['foto']}')
                        : AssetImage('lib/images/default.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    barber['nama_barber'] ?? 'Nama tidak tersedia',
                    style: GoogleFonts.lora(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Kontak: ${barber['kontak'] ?? 'Tidak tersedia'}',
                    style: GoogleFonts.lora(color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Layanan yang tersedia:',
                style: GoogleFonts.lora(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: barber['layanans']?.length ?? 0,
                itemBuilder: (context, index) {
                  final layanan = barber['layanans'][index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
                        child: Icon(Icons.cut, color: Colors.white),
                      ),
                      title: Text(
                        layanan['nama_layanan'],
                        style: GoogleFonts.lora(),
                      ),
                      subtitle: Text(
                        'Harga: ${layanan['harga']}',
                        style: GoogleFonts.lora(),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: barber['kontak'] != null
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                          size: 50,
                        ),
                        onPressed: () => _launchWhatsApp(barber['kontak']),
                      ),
                    )
                  : Center(
                      child: Text(
                        'Nomor WhatsApp tidak tersedia',
                        style: GoogleFonts.lora(color: Colors.grey),
                      ),
                    ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
