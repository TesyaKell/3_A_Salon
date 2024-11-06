import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

void main() {
  runApp(const RatingUlasanPage());
}

class RatingUlasan extends StatelessWidget {
  const RatingUlasan({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon Apps',
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: RatingUlasanPage(),
    );
  }
}

class RatingUlasanPage extends StatefulWidget {
  const RatingUlasanPage({super.key});

  @override
  State<RatingUlasanPage> createState() => _RatingUlasanPageState();
}

class _RatingUlasanPageState extends State<RatingUlasanPage> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final List<Map<String, dynamic>> _reviews = [];
  Uint8List?
      _selectedImage; // Untuk menyimpan gambar sebagai Uint8List (kompatibel dengan web)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating & Ulasan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Back action
          },
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilan Produk
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  // Gambar Produk
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      'https://res.cloudinary.com/dk0z4ums3/image/upload/v1606058022/attached_image/5-manfaat-creambath-untuk-kesehatan-rambut.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Nama Produk
                  Text(
                    'Creambath',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            // Teks Pertanyaan
            Center(
              child: Text(
                'Bagaimana Pengalaman Anda?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            // Rating Bintang
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _selectedRating
                        ? Icons.star_rate_rounded
                        : Icons.star_border_rounded,
                    color: Colors.yellow,
                    size: 54,
                  ),
                );
              }),
            ),
            SizedBox(height: 24.0),
            // Tambah Ulasan (Input)
            Text(
              'Tambah Ulasan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Ketik Di sini ...',
              ),
            ),
            SizedBox(height: 24.0),
            // Tambah Foto (Button)
            ElevatedButton.icon(
              onPressed: () async {
                // Aksi untuk memilih foto dari file picker
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null) {
                  setState(() {
                    _selectedImage = result
                        .files.first.bytes; // Gambar disimpan sebagai Uint8List
                  });
                }
              },
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              label: Text(
                'Tambah Foto',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            // Tombol Posting
            ElevatedButton(
              onPressed: () {
                if (_selectedRating > 0 && _reviewController.text.isNotEmpty) {
                  setState(() {
                    // Tambahkan ulasan dan rating ke dalam list
                    _reviews.add({
                      'rating': _selectedRating,
                      'review': _reviewController.text,
                      'image': _selectedImage, // Simpan foto yang dipilih
                    });

                    // Reset inputan setelah posting
                    _selectedRating = 0;
                    _reviewController.clear();
                    _selectedImage = null; // Reset foto setelah posting
                  });

                  // Tampilkan snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ulasan berhasil diposting!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  // Tampilkan error jika rating atau review kosong
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mohon tambahkan rating dan ulasan!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text(
                'Posting',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            // Daftar Ulasan yang sudah diposting
            Expanded(
              child: ListView.separated(
                itemCount: _reviews.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final review = _reviews[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(review['rating'], (i) {
                            return Icon(Icons.star_rate_rounded,
                                color: Colors.yellow, size: 20);
                          }),
                        ),
                        SizedBox(height: 8.0),
                        Text(review['review']),
                        SizedBox(height: 8.0),
                        // Jika ada gambar, tampilkan gambar
                        review['image'] != null
                            ? Image.memory(review['image'],
                                height: 100, fit: BoxFit.cover)
                            : SizedBox.shrink(),
                      ],
                    ),
                    leading: Icon(Icons.person, size: 40),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
