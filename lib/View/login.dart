import 'package:flutter/material.dart';
import 'package:a_3_salon/View/home.dart';
import 'package:a_3_salon/View/register.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 148, 175),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(top: 3),
                height: 260,
                child: Image.asset(
                  'images/1.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 39,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(35),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Username tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: usernameController,
                          helperTxt: "Inputkan User yang telah didaftar",
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        inputForm(
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Password kosong";
                            }
                            return null;
                          },
                          password: true,
                          controller: passwordController,
                          helperTxt: "Inputkan Password",
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  String usernameInput =
                                      usernameController.text;
                                  String passwordInput =
                                      passwordController.text;

                                  if (dataForm != null &&
                                      dataForm['username'] == usernameInput &&
                                      dataForm['password'] == passwordInput) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const ProfileView()),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text(
                                          'Username atau Password Salah',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel',
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK',
                                                style: TextStyle(fontSize: 14)),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text('Login'),
                            ),
                            TextButton(
                              onPressed: () {
                                pushRegister(context);
                              },
                              child: const Text('Belum punya akun?'),
                            ),
                          ],
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

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(),
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
          helperText: helperTxt,
          prefixIcon: iconData != null ? Icon(iconData) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
        ),
      ),
    );
  }
}

//coba
