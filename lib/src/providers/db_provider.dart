import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:psp_developer/src/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._internal();

  static const _DB_NAME = 'psp_developer.db';

  DBProvider._internal();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(await getDbPath(), version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(Constants.SQL_CREATE_TABLE_EXPERIENCES);

      await db.execute(Constants.SQL_CREATE_TABLE_PROJECTS);
      await db.execute(Constants.SQL_CREATE_TABLE_MODULES);

      await db.execute(Constants.SQL_CREATE_TABLE_PROGRAMS);
      await db.execute(Constants.SQL_CREATE_TABLE_LANGUAGES);

      await db.execute(Constants.SQL_CREATE_TABLE_DEFECT_LOGS);
      await db.execute(Constants.SQL_CREATE_TABLE_TIME_LOGS);

      await db.execute(Constants.SQL_CREATE_TABLE_TEST_REPORTS);
      await db.execute(Constants.SQL_CREATE_TABLE_PIP);
    });
  }

  Future<List<Map<String, dynamic>>> getAllModels(String tableName) async {
    final db = await DBProvider.db.database;
    return await db.query(tableName);
  }

  void deleteAll(String tableName) async {
    final db = await DBProvider.db.database;
    await db.rawDelete('DELETE FROM $tableName');
  }

  void deleteDb() async {
    await deleteDatabase(await getDbPath());
    _database = null;
  }

  Future<String> getDbPath() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, _DB_NAME);
  }

  void insert(dynamic model, String tableName) async {
    final db = await DBProvider.db.database;
    await db.insert(tableName, model.toJson());
  }

  void insertList(List<dynamic> models, String tableName) async {
    final db = await DBProvider.db.database;
    for (var model in models) {
      await db.insert(tableName, model.toJson());
    }
  }

  void update(dynamic model, String tableName) async {
    final db = await DBProvider.db.database;
    await db.update(tableName, model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<List<Map<String, dynamic>>> getAllByProjectId(
      projectId, String tableName) async {
    final db = await DBProvider.db.database;
    final res = await db
        .query(tableName, where: 'projects_id = ?', whereArgs: [projectId]);

    return res;
  }

  void deleteAllByProjectId(String projectId, String tableName) async {
    final db = await DBProvider.db.database;
    await db.rawDelete('DELETE FROM $tableName WHERE projects_id = $projectId');
  }

  // * Programs
  Future<List<Map<String, dynamic>>> getAllProgramsByModuleId(
      String moduleId) async {
    final db = await DBProvider.db.database;
    return await db.query(Constants.PROGRAMS_TABLE_NAME,
        where: 'modules_id = ?', whereArgs: [moduleId]);
  }

  void deleteAllByModuleId(String moduleId, String tableName) async {
    final db = await DBProvider.db.database;
    await db.rawDelete('DELETE FROM $tableName WHERE modules_id = $moduleId');
  }

  Future<List<Map<String, dynamic>>> getAllModelsByProgramId(
      String tableName, int programId) async {
    final db = await DBProvider.db.database;
    return await db
        .query(tableName, where: 'programs_id = ?', whereArgs: [programId]);
  }
}
