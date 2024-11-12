import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: ReceiptPage(),
    );
  }
}

class ReceiptPage extends StatefulWidget {
  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final ScreenshotController screenshotController = ScreenshotController();

  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        print("Permission granted");
        _getDownloadsFolder();
      } else {
        print("Permission denied");
      }
    } else if (Platform.isMacOS) {
      _getDownloadsFolder();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Receipt',
          style: TextStyle(
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
                          style: TextStyle(
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
                          style: TextStyle(
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
                              style: TextStyle(
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
                        _buildDetailRow('Customer Name', 'Loly'),
                        _buildDetailRow('Phone', '0852-6996-7894'),
                        _buildDetailRow('Booking Date', 'Oktober 11, 2024'),
                        _buildDetailRow('Booking Time', '17:45'),
                        _buildDetailRow('Stylist', 'Abel'),
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
                        _buildDetailRow('Hair Cut', 'IDR150.000,00'),
                        _buildDetailRow('Tax', 'IDR5.500,00'),
                        Divider(),
                        _buildDetailRow('Total', 'IDR155.500,00', isBold: true),
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
        color: Colors.pink,
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
                  _savePDFToDownloads(context, screenshotController);
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
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w600)),
          Text(
            value,
            style: TextStyle(
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
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Future<void> _savePDFToDownloads(
      BuildContext context, ScreenshotController screenshotController) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
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

        final downloadsDir = Directory('/storage/emulated/0/Download');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        final filePath = '${downloadsDir.path}/receipt.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved to Downloads folder: $filePath'),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save PDF'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
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
}
