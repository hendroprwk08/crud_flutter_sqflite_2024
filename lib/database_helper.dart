import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'kontak.dart';

class DatabaseHelper {
  static final _databaseName = "my_database.db";
  static final _databaseVersion = 1;
  static final _tableName = 'kontak';

  static final columnId = '_id';
  static final columnNama = 'nama';
  static final columnTelepon = 'telepon';
  static final columnEmail = 'email';

  // Membuat instance singleton dari DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._private();

  // Constructor private untuk membuat singleton
  DatabaseHelper._private();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // jika database belum ada, buat database baru
    _database = await _initDatabase();
    return _database;
  }

  // Inisialisasi database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Membuat tabel ketika database pertama kali dibuat
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $_tableName (
                $columnId INTEGER PRIMARY KEY,
                $columnNama TEXT,
                $columnTelepon TEXT,
                $columnEmail TEXT
              )
              ''');
  }

  // Metode untuk memasukkan data baru
  Future<int> insert(Kontak k) async {
    Database db = await instance.database;
    int id = await db.insert(_tableName, k.toMap());
    return id;
  }

  // Metode untuk mendapatkan semua data
  Future<List<Kontak>> getAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Kontak.fromMap(maps[i]);
    });
  }

  // Metode untuk memperbarui data
  Future<int> update(Kontak k) async {
    Database db = await instance.database;

    return await db.update(_tableName, k.toMap(),
        where: '$columnId = ?', whereArgs: [k.id]);
  }

  // Metode untuk menghapus data
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}