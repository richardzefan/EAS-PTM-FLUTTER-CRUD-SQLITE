import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_coba/model/model_mahasiswa.dart';
import 'package:sqlite_coba/model/model_user.dart';
import 'package:sqlite_coba/model/model_dosen.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database _database;

  final String tableName = 'tableMahasiswa';
  final String columnId = 'id';
  final String columnNbi = 'nbi';
  final String columnNama = 'Nama';
  final String columnAlamat = 'Alamat';
  final String columnTTL = 'TTL';
  final String columnProdi = 'Prodi';
  final String columnMobileNumber = 'mobileNumber';
  final String columnEmail = 'email';
  final String columnFakultas = 'Fakultas';
  final String columnIPK = 'IPK';
  final String columnDoswal = 'Doswal';
  final String columnFoto = 'Foto';

  final String tableName2 = 'tableUser';
  final String column2Id = 'id';
  final String column2Username = 'username';
  final String column2Password = 'password';
  final String column2Email = 'email';

  final String tableName3 = 'tableDosen';
  final String column3Id = 'id';
  final String column3Kode = 'kode';
  final String column3Nama = 'Nama';
  final String column3Alamat = 'Alamat';
  final String column3TTL = 'TTL';
  final String column3Prodi = 'Prodi';
  final String column3MobileNumber = 'mobileNumber';
  final String column3Email = 'email';
  final String column3Fakultas = 'Fakultas';
  final String column3Foto = 'Foto';

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'flutter_sqlite.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNbi TEXT,"
        "$columnNama TEXT , "
        "$columnAlamat TEXT , "
        "$columnTTL DATE , "
        "$columnMobileNumber TEXT ,"
        "$columnEmail TEXT,"
        '$columnProdi VARCHAR(255),'
        '$columnFakultas VARCHAR(255),'
        '$columnIPK VARCHAR(255),'
        '$columnFoto TEXT,'
        '$columnDoswal VARCHAR(255))';

    var sql2 = "CREATE TABLE $tableName2($column2Id INTEGER PRIMARY KEY, "
        "$column2Username TEXT , "
        "$column2Password TEXT , "
        "$column2Email TEXT)";

    var sql3 = "CREATE TABLE $tableName3($column3Id INTEGER PRIMARY KEY, "
        "$column3Kode TEXT,"
        "$column3Nama TEXT , "
        "$column3Alamat TEXT , "
        "$column3TTL DATE , "
        "$column3MobileNumber TEXT ,"
        "$column3Email TEXT,"
        '$column3Prodi VARCHAR(255),'
        '$column3Foto TEXT,'
        '$column3Fakultas VARCHAR(255))';

    await db.execute(sql);
    await db.execute(sql2);
    await db.execute(sql3);
  }

  //Mahasiswa
  Future<int> saveMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName, mahasiswa.toMap());
  }

  Future<int> saveUser(Modeluser user) async {
    var dbClient = await _db;
    int result = await dbClient.insert(tableName2, user.toMap());
    return result;
  }

  // Dosen
  Future<int> saveDosen(ModelDosen dosen) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName3, dosen.toMap());
  }

  //User-Login
  Future<Modeluser> checkLogin(String email, String password) async {
    var dbClient = await _db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableName2 WHERE email = '$email' AND password = '$password'");

    if (result.length > 0) {
      return Modeluser.fromMap(result.first);
    }
    return null;
  }

  // Future<List> getAllUser() async {

  // }

  //Mahasiswa
  Future<List> getAllMahasiswa() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName, columns: [
      columnId,
      columnNbi,
      columnNama,
      columnAlamat,
      columnTTL,
      columnProdi,
      columnMobileNumber,
      columnEmail,
      columnFakultas,
      columnIPK,
      columnDoswal,
      columnFoto,
    ]);

    return result.toList();
  }

  Future<int> updateMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName,
      mahasiswa.toMap(),
      where: '$columnId = ?',
      whereArgs: [mahasiswa.id],
    );
  }

  Future<int> deleteMahasiswa(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  //Dosen
  Future<List> getAllDosen() async {
    var dbClient = await _db;

    var result1 = await dbClient.query(tableName3, columns: [
      column3Id,
      column3Kode,
      column3Nama,
      column3Alamat,
      column3TTL,
      column3Prodi,
      column3MobileNumber,
      column3Email,
      column3Fakultas,
      column3Foto,
    ]);

    return result1.toList();
  }

  Future<int> updateDosen(ModelDosen dosen) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName3,
      dosen.toMap(),
      where: '$columnId = ?',
      whereArgs: [dosen.id],
    );
  }

  Future<int> deleteDosen(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName3,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
