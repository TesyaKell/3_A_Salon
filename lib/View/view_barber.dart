import 'package:a_3_salon/View/home.dart';
import 'package:a_3_salon/View/view_layanan.dart';
import 'package:a_3_salon/models/Barbers.dart';
import 'package:a_3_salon/models/Layanan.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:a_3_salon/View/reservation.dart';
import 'package:google_fonts/google_fonts.dart';

class BarberPage extends StatefulWidget {
  final Map? data;
  final List<Layanan>? dataLayanan;
  final List<Barbers> listBarbers;
  final int? discount;
  const BarberPage(
      {super.key,
      this.data,
      this.dataLayanan,
      required this.listBarbers,
      this.discount});

  @override
  _BarberPageState createState() => _BarberPageState();
}

class _BarberPageState extends State<BarberPage> {
  Barbers? selectedBarber;
  List<Barbers> barberList = [];
  bool isLoading = true;

// Function to fetch barbers from the API
  Future<void> fetchBarbers() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.6:8000/api/barbers'));

      if (response.statusCode == 200) {
        List<dynamic> temp = json.decode(response.body)['barbers'];
        print(temp);
        setState(() {
          barberList = temp.map((data) => Barbers.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load barbers');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching barbers: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBarbers();
  }

  @override
  Widget build(BuildContext context) {
    final Map? data = widget.data;
    final List<Layanan>? dataLayanan = widget.dataLayanan;
    final int? discount = widget.discount;
    List<Barbers> listBarber = widget.listBarbers;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _showExitConfirmationDialog(context);
          },
        ),
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while fetching data
            : Column(
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
                  Divider(thickness: 1.0, color: Colors.grey[400]),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barberList.length,
                      itemBuilder: (context, index) {
                        final barber = barberList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: selectedBarber == barber.nama_barber
                                ? const Color.fromRGBO(209, 164, 196, 1)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              barber.nama_barber, // Handle missing name
                              style: GoogleFonts.lora(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('lib/images/${barber.foto}')
                                      as ImageProvider,
                            ),
                            trailing: Radio<String>(
                              value: barber.nama_barber,
                              groupValue: selectedBarber?.nama_barber,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedBarber = barber;
                                });
                              },
                              activeColor:
                                  const Color.fromRGBO(212, 79, 168, 1),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        // "Add More" Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedBarber == null
                                ? null
                                : () {
                                    listBarber.add(selectedBarber!);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ServicesPage(
                                        data: data,
                                        listBarbers: listBarber,
                                        listLayanan: dataLayanan!,
                                        discount: discount,
                                      ),
                                    ));
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor:
                                  const Color.fromRGBO(210, 0, 98, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Add More',
                              style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Space between buttons
                        // "Next" Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedBarber == null
                                ? null
                                : () {
                                    if (dataLayanan!.length !=
                                        listBarber.length + 1) {
                                      var selisih = listBarber.length -
                                          dataLayanan.length +
                                          1;

                                      while (selisih != 0) {
                                        listBarber.removeLast();
                                        selisih--;
                                      }
                                    }

                                    listBarber.add(selectedBarber!);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReservationPage(
                                          data: data,
                                          dataBarber: listBarber,
                                          dataLayanan: dataLayanan,
                                          discount: discount,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor:
                                  const Color.fromRGBO(210, 0, 98, 1),
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
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    bool? shouldExit = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to go back to the home page?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (shouldExit == true) {
      Navigator.popUntil(
        context,
        (route) => route.isFirst,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(
            data: widget.data,
            targetIndex: 2,
          ),
        ),
      );
    }
  }
}
