import 'package:a_3_salon/View/history.dart';
import 'package:a_3_salon/View/historyReview.dart';
import 'package:a_3_salon/View/login.dart';
import 'package:flutter/material.dart';
import 'package:a_3_salon/View/ProfileDetailPage.dart';
import 'package:a_3_salon/View/contactSalon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io'; // INI COBA DOANG

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
    _data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(210, 0, 98, 1),
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
                        setState(() {
                          _data?.addAll(updatedData);
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final updatedData =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfilePage(data: _data),
                                    ),
                                  );

                                  if (updatedData != null) {
                                    setState(() {
                                      _data?.addAll(updatedData);
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      _data?['profileImagePath'] != null &&
                                              File(_data!['profileImagePath'])
                                                  .existsSync()
                                          ? FileImage(
                                              File(_data!['profileImagePath']))
                                          : null,
                                  child: _data?['profileImagePath'] == null
                                      ? Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.black54,
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _data?['fullName'] ?? 'Loly',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _data?['noTelp'] ?? '0852-6996-7894',
                                style: TextStyle(color: Colors.black87),
                              ),
                              Text(
                                _data?['email'] ?? 'lollii@gmail.com',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginView(
                                    data: _data,
                                  )));
                    }),
                  ],
                ),
              ),
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
        style: TextStyle(
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
      color: Colors.grey[300],
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.grey[700]),
        title: Text(title, style: TextStyle(color: Colors.black)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[700]),
        onTap: onTap,
      ),
    );
  }
}
