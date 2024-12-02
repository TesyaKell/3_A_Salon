import 'package:flutter/material.dart';
import 'package:a_3_salon/View/home.dart';
import 'package:a_3_salon/View/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({Key? key, this.data}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> loginUser() async {
    final String url = 'http://192.168.1.17:8000/api/login';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = json.encode({
      "username": usernameController.text,
      "password": passwordController.text,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['message'] == 'Login successful') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('id_customer', data['data']['id_customer']);
          prefs.setString('username', data['data']['username']);
          prefs.setString('nama_customer', data['data']['nama_customer']);
          prefs.setString('email', data['data']['email']);
          prefs.setString('nomor_telpon', data['data']['nomor_telpon']);

          Fluttertoast.showToast(
            msg: "Login Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 51, 122, 54),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeView()),
          );

          return true;
        } else {
          Fluttertoast.showToast(msg: "Kredensial tidak valid");
          return false;
        }
      } else {
        Fluttertoast.showToast(
          msg: "Username or Password is incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: const Color.fromARGB(255, 163, 29, 5),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return false;
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: "Error: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                _buildImage(constraints),
                _buildLoginText(),
                _buildLoginForm(constraints, dataForm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildImage(BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight * 0.35,
      child: Image.asset(
        'lib/images/1.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLoginText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: AppTextStyle.heading,
            ),
            const SizedBox(height: 5),
            Text(
              'Please Login to continue',
              style: AppTextStyle.subheading,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BoxConstraints constraints, Map? dataForm) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Username', usernameController, false),
                const SizedBox(height: 15),
                _buildTextField('Password', passwordController, true),
                const SizedBox(height: 20),
                _buildSignInButton(dataForm),
                const Spacer(),
                _buildSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.label),
        inputForm(
          (value) {
            if (value == null || value.isEmpty) {
              return "$label cannot be empty";
            }
            return null;
          },
          controller: controller,
          helperTxt: "Enter $label",
          password: isPassword,
        ),
      ],
    );
  }

  Widget _buildSignInButton(Map? dataForm) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              loginUser();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Sign In',
            style: GoogleFonts.lora(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      },
      child: Text(
        'Don’t have an account? Sign Up',
        style: GoogleFonts.lora(color: Colors.deepPurple),
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

class AppTextStyle {
  static TextStyle heading = GoogleFonts.lora(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle subheading = GoogleFonts.lora(
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle label = GoogleFonts.lora(
    fontWeight: FontWeight.normal,
    fontSize: 15.0,
  );
}
