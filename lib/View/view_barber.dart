import 'package:flutter/material.dart';
import 'package:a_3_salon/data/barber.dart';
<<<<<<< HEAD
=======
import 'package:a_3_salon/View/reservation.dart';
>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33

class BarberPage extends StatefulWidget {
  final Map? data;
  final Map? dataLayanan;
  const BarberPage({super.key, this.data, this.dataLayanan});

  @override
  _BarberPageState createState() => _BarberPageState();
}

class _BarberPageState extends State<BarberPage> {
<<<<<<< HEAD
  List<String> selectedBarbers = [];
=======
  String? selectedBarber;
>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33

  final List<String> staticOptions = [
    "Any Staff",
    "Any Male",
    "Any Female",
  ];

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    // Gabungkan opsi statis dengan daftar nama barber
    //pakai widget kalau statefull
    final Map? data = widget.data;
    final Map? dataLayanan = widget.dataLayanan;

>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33
    final combinedList = [
      ...staticOptions,
      ...barberList.map((barber) => barber.name),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barbers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
<<<<<<< HEAD
        backgroundColor: const Color.fromRGBO(80, 140, 155, 1),
=======
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 5.0, top: 9.0), // Space below the text
              child: Text(
                'Select a barber staff',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              thickness: 1.0, // garis pemisah
              color: Colors.grey[400],
            ),
            SizedBox(height: 10.0), // Space between divider and options
            Expanded(
              child: ListView.builder(
                itemCount: combinedList.length,
                itemBuilder: (context, index) {
                  final barberName = combinedList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
<<<<<<< HEAD
                      color: selectedBarbers.contains(barberName)
=======
                      color: selectedBarber == barberName
>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33
                          ? Colors.teal[100]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        barberName,
                        style: TextStyle(fontSize: 16),
                      ),
<<<<<<< HEAD
                      value: selectedBarbers.contains(barberName),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedBarbers.add(barberName);
                          } else {
                            selectedBarbers.remove(barberName);
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                      activeColor: Color.fromRGBO(80, 140, 155, 1),
                      secondary: CircleAvatar(
=======
                      leading: CircleAvatar(
>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33
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
                        activeColor: Color.fromRGBO(80, 140, 155, 1),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
<<<<<<< HEAD
            print("Selected Barbers: $selectedBarbers");
=======
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
>>>>>>> 53c3043dd9125bfb967aa40cb8c326f9498a2e33
          },
          child: Text('Next'),
        ),
      ),
    );
  }
}
