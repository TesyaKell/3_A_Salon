import 'package:flutter/material.dart';
import 'package:a_3_salon/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
      final _formKey = GlobalKey<FormState>();
      TextEditingController usernameController = TextEditingController();
      TextEditingController fullnameController = TextEditingController();
      TextEditingController emailController = TextEditingController();
      TextEditingController notelpController = TextEditingController();
      TextEditingController passwordController = TextEditingController();

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Phone Number Input
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

                          // Navigate to login view (add LoginView implementation)
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginView(data: formData)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 13, 1, 58),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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
                      
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      }
  }
