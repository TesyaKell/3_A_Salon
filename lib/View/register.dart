import 'package:flutter/material.dart';
import 'package:a_3_salon/View/login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

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
                          controller: usernameController,
                          hintTxt: "Username",
                          helperTxt: "Bernadeta",
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 5),
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
                          controller: fullNameController,
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
                          controller: emailController,
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
                          controller: notelpController,
                          hintTxt: "Phone Number",
                          helperTxt: "082123456789",
                          iconData: Icons.phone_android,
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
                          controller: passwordController,
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
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> formData = {};
                                formData['username'] = usernameController.text;
                                formData['fullName'] = fullNameController.text;
                                formData['email'] = emailController.text;
                                formData['password'] = passwordController.text;
                                formData['noTelp'] = notelpController.text;

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LoginView(data: formData),
                                  ),
                                );
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
                                fontWeight: FontWeight.bold, // Bold text
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
                                  builder: (context) => const LoginView()),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: password,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintTxt,
          hintStyle: GoogleFonts.lora(), // Lora font for hint text
          helperText: helperTxt,
          helperStyle: GoogleFonts.lora(), // Lora font for helper text
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
