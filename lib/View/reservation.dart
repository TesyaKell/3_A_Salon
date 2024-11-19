import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:a_3_salon/View/detailReservation.dart';

import 'package:google_fonts/google_fonts.dart';

class ReservationPage extends StatefulWidget {
  final Map? data;
  final Map? dataBarber;
  final Map? dataLayanan;
  final int? discount;

  const ReservationPage(
      {Key? key, this.data, this.dataBarber, this.dataLayanan, this.discount})
      : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isNameEditable = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedTime;

  final List<String> availableTimes = [
    "10.00",
    "10.20",
    "10.45",
    "11.00",
    "17.45",
    "18.00",
    "18.15",
    "18.30"
  ];

  @override
  void initState() {
    super.initState();
    Map? dataForm = widget.data;

    // Memberikan nilai default '' jika null
    nameController.text = dataForm?['fullName'] ?? '';
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map? dataForm = widget.data;
    final Map? dataFormBarber = widget.dataBarber;
    final Map? dataFormLayanan = widget.dataLayanan;
    final int? discount = widget.discount;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservation',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the Orderer's Name",
              style: GoogleFonts.lora(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              enabled: isNameEditable,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(228, 218, 218, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isNameEditable,
                  onChanged: (bool? value) {
                    setState(() {
                      isNameEditable = value ?? false;
                      if (!isNameEditable) {
                        nameController.text = widget.data?['fullName'] ?? '';
                      } else {
                        nameController.text = '';
                      }
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "The orderer's name is different from the account owner",
                    style: GoogleFonts.lora(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              "Select date & time",
              style: GoogleFonts.lora(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',
                filled: true,
                fillColor: const Color.fromRGBO(228, 218, 218, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  children: availableTimes.map((time) {
                    return ChoiceChip(
                      label: Text(
                        time,
                        style: GoogleFonts.lora(
                          color: selectedTime == time
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: selectedTime == time,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedTime = selected ? time : null;
                        });
                      },
                      selectedColor: const Color.fromRGBO(210, 0, 98, 1),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                          color: selectedTime == time
                              ? const Color.fromRGBO(210, 0, 98, 1)
                              : const Color.fromARGB(255, 31, 30, 30),
                          width: 1,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: (dateController.text.isEmpty || selectedTime == null)
              ? null // Nonaktifkan tombol jika tanggal atau waktu belum dipilih
              : () {
                  Map<String, dynamic> formData = {};
                  formData['date'] = dateController.text;
                  formData['time'] = selectedTime;

                  if (!isNameEditable) {
                    formData['fullName'] = dataForm?['fullName'] ?? "N/A";
                  } else {
                    formData['fullName'] = nameController.text;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailReservationPage(
                        data: dataForm,
                        dataBarber: dataFormBarber,
                        dataLayanan: dataFormLayanan,
                        dataReservasi: formData,
                        discount: discount ?? 0,
                      ),
                    ),
                  );
                },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            backgroundColor:
                (dateController.text.isEmpty || selectedTime == null)
                    ? Colors.grey // Warna tombol dinonaktifkan
                    : const Color.fromRGBO(210, 0, 98, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Next',
            style: GoogleFonts.lora(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
