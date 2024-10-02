import 'package:flutter/material.dart';

// ini kek widget custom
Padding inputForm(Function(String?) validasi,
    {required TextEditingController controller, // ngatur text yg msk mw d apkn
    required String hintTxt, // hint yg di dalam kotak
    // required String helperTxt, // helper yg di bawahnya kotak
    bool password = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 10),
    child: SizedBox(
        width: 350,
        child: TextFormField(
          validator: (value) => validasi(value),
          autofocus: true,
          controller: controller,
          obscureText: password,
          decoration: InputDecoration(
            labelText: hintTxt,
            hintText: hintTxt,
            border: const OutlineInputBorder(),
            // helperText: helperTxt,
          ),
        )),
  );
}
