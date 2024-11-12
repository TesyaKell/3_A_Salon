import 'package:flutter/material.dart';
import 'package:a_3_salon/data/barber.dart';
import 'package:a_3_salon/View/reservation.dart';
<<<<<<< HEAD
=======
import 'package:google_fonts/google_fonts.dart';
>>>>>>> d163e8b56a3db5a5ccd82e1158cd8c796b938fc2

class BarberPage extends StatefulWidget {
  final Map? data;
  final Map? dataLayanan;
  final int? discount;
  const BarberPage({super.key, this.data, this.dataLayanan, this.discount});

  @override
  _BarberPageState createState() => _BarberPageState();
}

class _BarberPageState extends State<BarberPage> {
  String? selectedBarber;

  final List<String> staticOptions = [
    "Any Staff",
    "Any Male",
    "Any Female",
  ];

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Gabungkan opsi statis dengan daftar nama barber
    //pakai widget kalau statefull
=======
>>>>>>> d163e8b56a3db5a5ccd82e1158cd8c796b938fc2
    final Map? data = widget.data;
    final Map? dataLayanan = widget.dataLayanan;
    final int? discount = widget.discount;

    final combinedList = [
      ...staticOptions,
      ...barberList.map((barber) => barber.name),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barbers',
          style: GoogleFonts.lora(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 9.0),
              child: Text(
                'Select a barber staff',
                style: GoogleFonts.lora(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.grey[400],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: combinedList.length,
                itemBuilder: (context, index) {
                  final barberName = combinedList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: selectedBarber == barberName
<<<<<<< HEAD
                          ? Colors.teal[100]
=======
                          ? const Color.fromRGBO(209, 164, 196, 1)
>>>>>>> d163e8b56a3db5a5ccd82e1158cd8c796b938fc2
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        barberName,
                        style: GoogleFonts.lora(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      leading: CircleAvatar(
                        child: Text(barberName[0]),
                      ),
                      trailing: Radio<String>(
                        value: barberName,
                        groupValue: selectedBarber,
                        onChanged: (String? value) {
                          setState(() {
                            selectedBarber = value;
                          });
                        },
                        activeColor: Color.fromRGBO(212, 79, 168, 1),
                      ),
                    ),
                  );
                },
              ),
            ),
<<<<<<< HEAD
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Map<String, dynamic> formData = {};
            formData['barberName'] = selectedBarber;
            // Arahkan ke hlmn Reservation dngn nama barber yg dipilih sblmnya
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReservationPage(
                    data: data, dataBarber: formData, dataLayanan: dataLayanan),
              ),
            );
          },
          child: Text('Next'),
=======
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Map<String, dynamic> formData = {};
                    formData['barberName'] = selectedBarber;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationPage(
                            data: data,
                            dataBarber: formData,
                            dataLayanan: dataLayanan,
                            discount: discount),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 40),
                    backgroundColor: const Color.fromRGBO(209, 164, 196, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.lora(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
>>>>>>> d163e8b56a3db5a5ccd82e1158cd8c796b938fc2
        ),
      ),
    );
  }
}
