import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Dphelper1 {
  Future<Database> setdb() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_swp");
    var database = await openDatabase(path, version: 1, onCreate: createdb);
    return database;
  }

  Future<void> createdb(Database database, int version) async {
    var sql =
        "CREATE TABLE book1(id INTEGER PRIMARY KEY,selectIndex INTEGER NOT NULL , imageUrl TEXT);";
    await database.execute(sql);
  }
}
