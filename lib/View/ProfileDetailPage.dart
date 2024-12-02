import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final Map? data;
  const EditProfilePage({super.key, this.data});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Map? _data;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? _profileImage;

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
        'username': prefs.getString('username') ?? 'username Tidak Ditemukan',
        'profileImagePath': prefs.getString('profileImagePath'),
      };

      nameController.text = _data?['fullName'] ?? '';
      emailController.text = _data?['email'] ?? '';
      phoneController.text = _data?['nomor_telpon'] ?? '';
      usernameController.text = _data?['username'] ?? '';
    });
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("Camera"),
            onTap: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                setState(() {
                  _profileImage = File(pickedFile.path);
                });
              }
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Gallery"),
            onTap: () async {
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _profileImage = File(pickedFile.path);
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(210, 0, 98, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Lora",
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(210, 0, 98, 1),
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: () => _showImageSourceActionSheet(context),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.black,
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 5,
                      child: GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  buildNonEditableField("Username", usernameController),
                  const SizedBox(height: 10),
                  buildEditableField("Name", nameController),
                  const SizedBox(height: 10),
                  buildEditableField("Email", emailController),
                  const SizedBox(height: 10),
                  buildEditableField("Phone Number", phoneController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> updatedData = {
                        'fullName': nameController.text,
                        'email': emailController.text,
                        'nomor_telpon': phoneController.text,
                        'profileImagePath': _profileImage?.path,
                      };
                      Navigator.pop(context, updatedData);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Update", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: Icon(Icons.edit, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget buildNonEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
