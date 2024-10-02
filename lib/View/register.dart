import 'package:flutter/material.dart';
// import 'package:a_3_salon/View/login.dart';
import 'package:a_3_salon/component/form_component.dart';
import 'package:a_3_salon/utilities/constant.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Untuk validasi harus menggunakan GlobalKey
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk setiap input field
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00796B),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Register',
              style: kTextStyle1,
            ),
            const Text(
              'Please Register to Login',
              style: kTextStyle5,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Warna latar belakang Container
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Input form untuk Username
                    inputForm(
                      (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Username tidak boleh kosong";
                        }
                        if (p0.toLowerCase() == 'anjing') {
                          return "Tidak boleh menggunakan kata kasar";
                        }
                        return null;
                      },
                      controller: usernameController,
                      hintTxt: "Username",
                    ),
                    const SizedBox(height: 20), // Jarak antar input field
                    // Input form untuk Full Name
                    inputForm(
                      (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Full Name tidak boleh kosong";
                        }
                        return null;
                      },
                      controller: fullnameController,
                      hintTxt: "Full Name",
                    ),
                    const SizedBox(height: 20),
                    // Input form untuk Email
                    inputForm(
                      (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return "Email tidak boleh kosong";
                        }
                        if (!p0.contains('@')) {
                          return "Email harus menggunakan @";
                        }
                        return null;
                      },
                      controller: emailController,
                      hintTxt: "Email",
                    ),
                    inputForm(
                      (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Phone Number cannot be empty';
                        }
                        if (p0.length < 5) {
                          return 'Phone Number minimum 5 digits';
                        }
                        return null;
                      },
                      controller: notelpController,
                      hintTxt: "Phone Number",
                    ),
                    const SizedBox(height: 20),

                    // Password Input
                    inputForm(
                      (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return 'Password Tidak Boleh Kosong';
                        }
                        if (p0.length < 5) {
                          return 'Password minimal 5 digit';
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintTxt: "Password",
                      password: true,
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> formData = {};
                          formData['username'] = usernameController.text;
                          formData['password'] = passwordController.text;

                          //  Navigate to login view (add LoginView implementation)
                          //  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 13, 1, 58),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Tautan ke halaman login
                    // TextButton(
                    //   onPressed: () {
                    //     // Navigasi ke halaman login
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const LoginView(),
                    //       ),
                    //     );
                    //   },
                    //   child: const Text(
                    //     'Already Have Account? Sign In',
                    //     style: TextStyle(
                    //       color: Colors.deepPurple,
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
