import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.loraTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: ReceiptPage(
        dataReservasi: {
          'fullName': 'John Doe',
          'date': '2024-11-12',
          'time': '14:30',
          'noTelp': '1234567890',
        },
        dataBarber: {
          'barberName': 'Stylist A',
        },
        dataLayanan: {
          'layananName': 'Hair Cut',
          'layananPrice': '150000',
        },
      ),
    );
  }
}

class ReceiptPage extends StatefulWidget {
  final Map<String, String?>? dataReservasi;
  final Map<String, String?>? dataBarber;
  final Map<String, String?>? dataLayanan;
  final int? discount;

  const ReceiptPage(
      {Key? key,
      this.dataReservasi,
      this.dataBarber,
      this.dataLayanan,
      this.discount})
      : super(key: key);

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print("Permission granted");
    } else {
      print("Permission denied");
      openAppSettings();
    }

    if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        print("Manage External Storage permission granted");
      } else {
        print("Permission denied");
        openAppSettings();
      }
    }
  }

  Future<void> _getDownloadsFolder() async {
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = await getExternalStorageDirectory();
    } else if (Platform.isMacOS) {
      downloadsDirectory = await getDownloadsDirectory();
    }

    if (downloadsDirectory != null) {
      print("Downloads folder path: ${downloadsDirectory.path}");
    } else {
      print("Unable to access Downloads folder.");
    }
  }

  @override
  Widget build(BuildContext context) {
    String customerName = widget.dataReservasi?['fullName'] ?? 'N/A';
    String date = widget.dataReservasi?['date'] ?? 'N/A';
    String time = widget.dataReservasi?['time'] ?? 'N/A';
    String barberName = widget.dataBarber?['barberName'] ?? 'N/A';
    String serviceName = widget.dataLayanan?['layananName'] ?? 'N/A';
    int servicePrice =
        int.tryParse(widget.dataLayanan?['layananPrice'] ?? '0') ?? 0;
    double discountPrice = servicePrice.toDouble();
    if (widget.discount! > 0) {
      discountPrice -= discountPrice * (widget.discount!.toDouble() / 100);
    }
    double tax = servicePrice * 0.035;
    double total = discountPrice + tax;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(210, 0, 98, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Receipt',
          style: GoogleFonts.lora(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'ATMA SALON',
                          style: GoogleFonts.lora(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAwezRRmbnUqJh9gH3bwbnIJjt7l5nCj21sA&sg',
                          width: 120,
                          height: 120,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Scan this QR code at the salon for quick check-in.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lora(
                              fontSize: 14,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Jl. Babarsari NO 105, Kledokan, Kec. Depok,\nKab. Sleman, Daerah Istimewa Yogyakarta',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.lora(
                                  fontSize: 12, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Status', 'Paid off'),
                        _buildDetailRow('Customer Name', customerName),
                        _buildDetailRow('Booking Date', date),
                        _buildDetailRow('Booking Time', time),
                        _buildDetailRow('Stylist', barberName),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('$serviceName',
                            'IDR ${servicePrice.toStringAsFixed(0)},00'),
                        widget.discount != 0
                            ? _buildDetailRow('Discount ${widget.discount}%',
                                'IDR ${(servicePrice - discountPrice).toStringAsFixed(0)},00')
                            : Container(),
                        _buildDetailRow(
                            'Tax', 'IDR ${tax.toStringAsFixed(0)},00'),
                        Divider(),
                        _buildDetailRow(
                            'Total', 'IDR ${total.toStringAsFixed(0)},00',
                            isBold: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(210, 0, 98, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  _saveAndSharePDF(context, screenshotController);
                },
                child: _buildFooterButton(Icons.share, 'SHARE'),
              ),
              VerticalDivider(),
              GestureDetector(
                onTap: () async {
                  _printPDF(context, screenshotController);
                },
                child: _buildFooterButton(Icons.download, 'DOWNLOAD'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.lora(
                  fontSize: 14,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w600)),
          Text(
            value,
            style: GoogleFonts.lora(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.lora(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

Future<void> _printPDF(
    BuildContext context, ScreenshotController screenshotController) async {
  try {
    final image = await screenshotController.capture();
    if (image == null) return;

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(image)),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        return await pdf.save();
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Print initiated!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to print PDF')),
    );
  }
}

Future<void> _saveAndSharePDF(
    BuildContext context, ScreenshotController screenshotController) async {
  try {
    final image = await screenshotController.capture();
    if (image == null) return;

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(image)),
          );
        },
      ),
    );

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/receipt.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    Share.shareXFiles([XFile(filePath)], text: 'Receipt');
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to capture screenshot or generate PDF'),
      ),
    );
  }
}
