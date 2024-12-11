import 'package:a_3_salon/View/history.dart';
import 'package:a_3_salon/View/historyReview.dart';
import 'package:a_3_salon/View/login.dart';
import 'package:flutter/material.dart';
import 'package:a_3_salon/View/ProfileDetailPage.dart';
import 'package:a_3_salon/View/contactSalon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ProfileView extends StatefulWidget {
  final Map? data;
  const ProfileView({super.key, this.data});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Map? _data;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _data = {
        'fullName': prefs.getString('nama_customer') ?? 'Nama Tidak Ditemukan',
        'email': prefs.getString('email') ?? 'Email Tidak Ditemukan',
        'nomor_telpon':
            prefs.getString('nomor_telpon') ?? 'No Telp Tidak Ditemukan',
        'foto': prefs.getString('foto'),
      };
      print('Data saat ini: $_data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(210, 0, 98, 1),
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: GestureDetector(
              onTap: () async {
                final updatedData = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(data: _data),
                  ),
                );
                if (updatedData != null) {
                  _loadUserData();
                }
              },
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(210, 0, 98, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: _data?['foto'] != null &&
                                  File(_data!['foto']).existsSync()
                              ? FileImage(File(_data!['foto']))
                              : null,
                          child: _data?['foto'] == null
                              ? Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.black54,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 22),
                            Text(
                              _data?['fullName'] ?? 'Nama Tidak Ditemukan',
                              style: GoogleFonts.lora(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 3,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _data?['nomor_telpon'] ?? 'null',
                              style: GoogleFonts.lora(
                                color: Colors.white, // Change to white
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _data?['email'] ?? 'null',
                              style: GoogleFonts.lora(
                                color: Colors.white, // Change to white
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle('Fitur Member'),
              customCard(Icons.store, 'Contact Salon', onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => contactSalonPage(),
                  ),
                );
              }),
              sectionTitle('Akun'),
              customCard(Icons.star, 'Rating & Reviews', onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryReviewPage(),
                  ),
                );
              }),
              customCard(Icons.history, 'Order History', onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ),
                );
              }),
              sectionTitle('Info Lainnya'),
              customCard(Icons.logout, 'Logout', onTap: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Konfirmasi',
                        style: GoogleFonts.lora(fontWeight: FontWeight.bold),
                      ),
                      content: Text(
                        'Apakah anda akan keluar dari akun?',
                        style: GoogleFonts.lora(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Menutup dialog
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.lora(color: Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // Proses logout
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.clear(); // Hapus semua data user

                            Navigator.of(context).pop(); // Tutup dialog
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(data: null),
                              ),
                            );
                          },
                          child: Text(
                            'Yes',
                            style: GoogleFonts.lora(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: GoogleFonts.lora(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget customCard(IconData icon, String title, {VoidCallback? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[100],
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.grey[700]),
        title: Text(title, style: GoogleFonts.lora(color: Colors.black)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
        onTap: onTap,
      ),
    );
  }
}
