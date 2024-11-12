import 'package:flutter/material.dart';
import 'package:a_3_salon/data/barber.dart';

class BarberPage extends StatefulWidget {
  const BarberPage({super.key});

  @override
  _BarberPageState createState() => _BarberPageState();
}

class _BarberPageState extends State<BarberPage> {
  List<String> selectedBarbers = [];

  final List<String> staticOptions = [
    "Any Staff",
    "Any Male",
    "Any Female",
  ];

  @override
  Widget build(BuildContext context) {
    final combinedList = [
      ...staticOptions,
      ...barberList.map((barber) => barber.name),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Barbers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(80, 140, 155, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Select a barber staff',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: combinedList.length,
                itemBuilder: (context, index) {
                  final barberName = combinedList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: selectedBarbers.contains(barberName)
                          ? Colors.teal[100]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        barberName,
                        style: const TextStyle(fontSize: 16),
                      ),
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
                      activeColor: const Color.fromRGBO(80, 140, 155, 1),
                      secondary: CircleAvatar(
                        child: Text(barberName[0]),
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
            print("Selected Barbers: $selectedBarbers");
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}
