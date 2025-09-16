import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/medication_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  static const String _dbName = 'medications.db';
  static const String _tableName = 'medications';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        reminderTimes TEXT NOT NULL
      )
    ''');
  }

  Future<void> createMedication(MedicationModel med) async {
    final db = await instance.database;
    await db.insert(_tableName, med.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MedicationModel>> getAllMedications() async {
    final db = await instance.database;
    final maps = await db.query(_tableName, orderBy: 'name ASC');
    return List.generate(maps.length, (i) => MedicationModel.fromMap(maps[i]));
  }

  Future<void> updateMedication(MedicationModel med) async {
    final db = await instance.database;
    await db.update(_tableName, med.toMap(), where: 'id = ?', whereArgs: [med.id]);
  }

  Future<void> deleteMedication(String id) async {
    final db = await instance.database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}