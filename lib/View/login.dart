import 'package:flutter/material.dart';
import 'package:a_3_salon/View/register.dart';
import 'package:a_3_salon/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TextEditingController
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            //kolom untuk  pass and user
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Input Username
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Username tidak boleh kosong";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Inputkan User yang telah didaftar",
                  iconData: Icons.person),
              // Input Password
              inputForm((p0) {
                if (p0 == null || p0.isEmpty) {
                  return "Password tidak boleh kosong";
                }
                return null;
              },
                  controller: passwordController,
                  hintTxt: "Password",
                  helperTxt: "Inputkan Password",
                  iconData: Icons.lock),
              // Baris yang berisi tombol login dan tombol ke halaman register
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      // Cek apakah form valid
                      if (_formKey.currentState!.validate()) {
                        // Cek apakah username dan password sesuai dengan data dari halaman register
                        if (dataForm!['username'] == usernameController.text &&
                            dataForm['password'] == passwordController.text) {
                          // Jika sesuai, navigasi ke halaman Home
                        } else {
                          // Jika tidak sesuai, tampilkan alert dialog
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Password Salah'),
                              content: TextButton(
                                  onPressed: () => pushRegister(context),
                                  child: const Text('Daftar Disini !!')),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  // Tombol ke halaman register
                  TextButton(
                      onPressed: () {
                        Map<String, dynamic> formData = {};
                        formData['username'] = usernameController.text;
                        formData['password'] = passwordController.text;
                        pushRegister(context);
                      },
                      child: const Text('Belum punya akun?')),
                ],
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
}
