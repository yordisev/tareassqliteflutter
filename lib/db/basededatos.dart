import 'package:alarmasqlite/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tablaName = "db_tareas";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'basededatos.db';
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print('creando una nueva');
        return db.execute(
          "CREATE TABLE $_tablaName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "titulo STRING, nota TEXT, fecha STRING,"
          "horainico STRING, horafin STRING,"
          "redimir INTEGER, repetir STRING,"
          "color INTEGER,"
          "siCompleted INTEGER)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(TareasResponse? tareasResponse) async {
    print('funcion para insertar');
    return await _db?.insert(_tablaName, tareasResponse!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('Listar Tareas');
    return await _db!.query(_tablaName);
  }

  static delete(TareasResponse tareasResponse) async {
    return await _db!
        .delete(_tablaName, where: 'id=?', whereArgs: [tareasResponse.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
                  UPDATE db_tareas SET siCompleted = ?
                  WHERE id=?
                  ''', [1, id]);
  }
}
