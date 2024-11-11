import 'package:flutter/material.dart';
import 'package:a_3_salon/View/login.dart';

class ProfileView extends StatelessWidget {
  final Map? data;
  const ProfileView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(80, 140, 155, 1),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('lib/images/loli.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?['fullName'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        data?['noTelp'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        data?['email'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle('Fitur Member'),
                      customCard(Icons.card_giftcard, 'Promo & Voucher'),
                      customCard(Icons.vibration, 'Shake & Get'),
                      sectionTitle('Akun'),
                      customCard(Icons.star, 'Rating & Reviews'),
                      customCard(Icons.history, 'Order History'),
                      sectionTitle('Info Lainnya'),
                      customCard(Icons.settings, 'Settings'),
                      customCard(Icons.contact_mail, 'Contact US'),
                      customCard(Icons.logout, 'Logout', onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginView(data: data)),
                          (Route<dynamic> route) => false,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget customCard(IconData icon, String title, {VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.grey[700]),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
