import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'salon_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pemesanan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama_pemesan TEXT,
            tanggal TEXT,
            waktu TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE detail_pemesanan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_layanan INTEGER,
            id_barber INTEGER,
            id_pemesanan INTEGER,
            FOREIGN KEY(id_pemesanan) REFERENCES pemesanan(id)
          )
        ''');
      },
    );
  }

  Future<int> insertPemesanan(Map<String, dynamic> pemesanan) async {
    final db = await database;
    return await db.insert('pemesanan', pemesanan);
  }

  Future<int> insertDetailPemesanan(
      Map<String, dynamic> detailPemesanan) async {
    final db = await database;
    return await db.insert('detail_pemesanan', detailPemesanan);
  }
}
