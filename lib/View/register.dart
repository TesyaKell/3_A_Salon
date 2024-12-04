import 'package:flutter/material.dart';
import 'package:a_3_salon/View/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> controllers = {
    'username': TextEditingController(),
    'nama_customer': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'nomor_telpon': TextEditingController(),
  };
  bool isLoading = false;

  Future<void> registerUser() async {
    print('Username: ${controllers['username']!.text}');
    print('Password: ${controllers['password']!.text}');
    final String url = 'http://10.32.248.5:8000/api/customers';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = json.encode({
      "username": controllers['username']!.text,
      "nama_customer": controllers['nama_customer']!.text,
      "email": controllers['email']!.text,
      "password": controllers['password']!.text,
      "nomor_telpon": controllers['nomor_telpon']!.text,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.headers['content-type']?.contains('text/html') ?? false) {
        print('Server mengembalikan halaman HTML, bukan JSON.');
        print(response.body);
      } else if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        print("Registrasi gagal: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(top: 3),
                height: 200,
                child: Image.asset(
                  'lib/images/1.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: GoogleFonts.lora(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Please Register to Login',
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Username cannot be empty";
                            }
                            if (value.toLowerCase() == "anjing") {
                              return "Profanity is not allowed";
                            }
                            return null;
                          },
                          controller: controllers['username'],
                          hintTxt: "Username",
                          helperTxt: "Bernadeta",
                          iconData: Icons.person,
                        ),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Full Name cannot be empty";
                            }
                            if (value.toLowerCase() == "anjing") {
                              return "Profanity is not allowed";
                            }
                            return null;
                          },
                          controller: controllers['nama_customer'],
                          hintTxt: "Full Name",
                          helperTxt: "Bernadeta Ind",
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 5),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email cannot be empty';
                            }
                            if (!value.contains('@')) {
                              return 'Email must contain @';
                            }
                            return null;
                          },
                          controller: controllers['email'],
                          hintTxt: "Email",
                          helperTxt: "bernadeta@gmail.com",
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 5),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone number cannot be empty";
                            }

                            RegExp regex = RegExp(r'^[0-9]+$');
                            if (!regex.hasMatch(value)) {
                              return "Phone number can only contain numbers";
                            }
                            return null;
                          },
                          controller: controllers['nomor_telpon'],
                          hintTxt: "Phone Number",
                          helperTxt: "082123456789",
                          iconData: Icons.phone_android,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password cannot be empty';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          controller: controllers['password'],
                          hintTxt: "Password",
                          helperTxt: "xxxxxxx",
                          iconData: Icons.lock,
                          password: true,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              print(
                                  'Username: ${controllers['username']!.text}');
                              print(
                                  'Password: ${controllers['password']!.text}');
                              if (_formKey.currentState!.validate()) {
                                registerUser();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.lora(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(
                                  data: {
                                    'username': controllers['username']?.text,
                                    'password': controllers['password']?.text,
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Already Have Account? Sign In',
                            style: GoogleFonts.lora(
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputForm(
    String? Function(String?)? validator, {
    TextEditingController? controller,
    String? hintTxt,
    String? helperTxt,
    bool password = false,
    IconData? iconData,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: password,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintTxt,
          hintStyle: GoogleFonts.lora(),
          helperText: helperTxt,
          helperStyle: GoogleFonts.lora(),
          prefixIcon: iconData != null ? Icon(iconData) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
        ),
      ),
    );
  }
}
