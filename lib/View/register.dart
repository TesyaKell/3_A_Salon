import 'package:flutter/material.dart';
import 'package:a_3_salon/View/login.dart';
import 'package:a_3_salon/component/form_component.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 200,
                  child: Image.asset(
                    'images/1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Please Register to Login',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(80, 140, 155, 1),
                  ),
                ),
                const SizedBox(height: 20),
                inputForm(
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Username tidak boleh kosong";
                    }
                    if (value.toLowerCase() == "anjing") {
                      return "Tidak boleh menggunakan kata kasar";
                    }
                    return null;
                  },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Ucup44",
                  iconData: Icons.person,
                ),
                const SizedBox(height: 15),
                inputForm(
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Full Name tidak boleh kosong";
                    }
                    if (value.toLowerCase() == "anjing") {
                      return "Tidak boleh menggunakan kata kasar";
                    }
                    return null;
                  },
                  controller: fullNameController,
                  hintTxt: "Full Name",
                  helperTxt: "Ucup Surucup",
                  iconData: Icons.person,
                ),
                const SizedBox(height: 15),
                inputForm(
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!value.contains('@')) {
                      return 'Email harus menggunakan @';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintTxt: "Email",
                  helperTxt: "ucup@gmail.com",
                  iconData: Icons.email,
                ),
                const SizedBox(height: 15),
                inputForm(
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 5) {
                      return 'Password minimal 5 karakter';
                    }
                    return null;
                  },
                  controller: passwordController,
                  hintTxt: "Password",
                  helperTxt: "xxxxxxx",
                  iconData: Icons.lock,
                  password: true,
                ),
                const SizedBox(height: 15),
                inputForm(
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Nomor Telepon tidak boleh kosong";
                    }

                    RegExp regex = RegExp(r'^[0-9]+$');
                    if (!regex.hasMatch(value)) {
                      return "Nomor Telepon hanya boleh berisi angka";
                    }
                    return null;
                  },
                  controller: notelpController,
                  hintTxt: "No Telp",
                  helperTxt: "082123456789",
                  iconData: Icons.phone_android,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
                          builder: (context) => LoginView(data: formData),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    backgroundColor: const Color.fromRGBO(80, 140, 155, 1),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  },
                  child: const Text(
                    'Already Have Account? Sign In',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: password,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintTxt,
          helperText: helperTxt,
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

//coba