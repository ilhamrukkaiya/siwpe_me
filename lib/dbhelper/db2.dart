import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Dphelper2 {
  Future<Database?> setdb2() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_swp2");
    var database = await openDatabase(path, version: 1, onCreate: createdb2);
    return database;
  }

  Future<void> createdb2(Database database, int version) async {
    var sql2 =
        "CREATE TABLE book2(id INTEGER PRIMARY KEY,selectIndex INTEGER NOT NULL , imageUrl TEXT);";
    await database.execute(sql2);
  }
}
