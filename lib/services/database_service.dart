import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ticket_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tenanthub.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tickets (
      id TEXT PRIMARY KEY,
      trxId TEXT,
      title TEXT,
      date TEXT,
      time TEXT,
      location TEXT,
      image TEXT,
      boothName TEXT,
      price TEXT,
      status TEXT,
      paymentMethod TEXT
    )
    ''');
  }

  Future<void> insertTicket(TicketModel ticket) async {
    final db = await instance.database;
    await db.insert(
      'tickets',
      ticket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TicketModel>> fetchAllTickets() async {
    final db = await instance.database;
    final result = await db.query('tickets', orderBy: 'id DESC');
    return result.map((map) => TicketModel.fromMap(map)).toList();
  }

  Future<void> updateTicketStatus(String id, String newStatus) async {
    final db = await instance.database;
    await db.update(
      'tickets',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
