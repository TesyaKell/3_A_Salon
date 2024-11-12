import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:a_3_salon/View/detailReservation.dart';

class ReservationPage extends StatefulWidget {
  //menerima dan mengambil dari page lain
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

  final List<String> availableTimes = ["17.45", "18.00", "18.15", "18.30"];

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
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nameController,
              enabled: isNameEditable,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
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
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Select date & time",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: 'dd/mm/yyyy',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: availableTimes.map((time) {
                return ChoiceChip(
                  label: Text(time),
                  selected: selectedTime == time,
                  onSelected: (bool selected) {
                    setState(() {
                      selectedTime = selected ? time : null;
                    });
                  },
                  selectedColor: Colors.pinkAccent[100],
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: selectedTime == time ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Proceed to the next step with the name, date, and time details
            print("Name: ${nameController.text}");
            print("Date: ${dateController.text}");
            print("Time: $selectedTime");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
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
            child: Text('Next'),
          ),
        ),
      ),
    );
  }
}
