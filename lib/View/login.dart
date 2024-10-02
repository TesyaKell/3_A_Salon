import 'package:flutter/material.dart';
import 'package:a_3_salon/View/register.dart';

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
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Map? dataForm = widget.data;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 72, 148, 175),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: const EdgeInsets.all(33),
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
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      inputForm(
                        (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "Username tidak boleh kosong";
                          }
                          return null;
                        },
                        controller: usernameController,
                        helperTxt: "Inputkan User yang telah didaftar",
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      inputForm(
                        (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "Password kosong";
                          }
                          return null;
                        },
                        password: true,
                        controller: passwordController,
                        helperTxt: "Inputkan Password",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Tombol login
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (dataForm!['username'] ==
                                        usernameController.text &&
                                    dataForm['password'] ==
                                        passwordController.text) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginView()),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Password Salah'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
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

  Widget inputForm(String? Function(String?)? validator,
      {TextEditingController? controller,
      String? hintTxt,
      String? helperTxt,
      bool password = false,
      IconData? iconData}) {
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
            borderRadius: BorderRadius.circular(30.0), // Sudut melengkung
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Sudut melengkung
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0), // Sudut melengkung
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
        ),
      ),
    );
  }
}
