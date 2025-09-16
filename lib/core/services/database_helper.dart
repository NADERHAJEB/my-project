
// lib/core/services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Medicine {
  final int? id;
  final String name;
  final String dose;
  final DateTime time;
  final String? imagePath;

  Medicine({this.id, required this.name, required this.dose, required this.time, this.imagePath});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'dose': dose,
    'time': time.toIso8601String(),
    'imagePath': imagePath,
  };

  factory Medicine.fromMap(Map<String, dynamic> map) => Medicine(
    id: map['id'],
    name: map['name'],
    dose: map['dose'],
    time: DateTime.parse(map['time']),
    imagePath: map['imagePath'],
  );
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<DatabaseHelper> init() async {
    _database = await _initDB();
    return this;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'medicines_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medicines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        dose TEXT NOT NULL,
        time TEXT NOT NULL,
        imagePath TEXT
      )
    ''');
  }

  Future<Medicine> addMedicine(Medicine medicine) async {
    final db = await database;
    final id = await db.insert('medicines', medicine.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return Medicine(id: id, name: medicine.name, dose: medicine.dose, time: medicine.time, imagePath: medicine.imagePath);
  }

  Future<List<Medicine>> getMedicines() async {
    final db = await database;
    final maps = await db.query('medicines', orderBy: 'time ASC');
    return List.generate(maps.length, (i) => Medicine.fromMap(maps[i]));
  }

  Future<int> updateMedicine(Medicine medicine) async {
    final db = await database;
    return await db.update('medicines', medicine.toMap(), where: 'id = ?', whereArgs: [medicine.id]);
  }

  Future<int> deleteMedicine(int id) async {
    final db = await database;
    return await db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }
}