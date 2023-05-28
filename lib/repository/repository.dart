import 'package:sqflite/sqflite.dart';
import 'package:swipe_me/dbhelper/dp.dart';

import '../model/cont1model.dart';

class Repository {
  late Dphelper1 _dphelper;
  Repository() {
    _dphelper = Dphelper1();
  }
  static Database? _database;

  Future<Database?> getAlldatabase() async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dphelper.setdb();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var db = _database;
    return await db!.query("book1");
  }

  Future<void> saveimage(Cont1modl cont1modl) async {
    await getAlldatabase();
    var db = _database;

    await db?.insert("book1", cont1modl.toMap());
    await db!.rawQuery('SELECT * FROM book1');
  }

  Future<List<Cont1modl>> getimage() async {
    await getAlldatabase();
    var db = _database;
    var data = await db!.rawQuery('SELECT * FROM book1');

    return List<Cont1modl>.from(data.map((e) => Cont1modl.fromMap(e)));
  }

  delete(id) async {
    var db = _database;
    return await db?.delete('book1', where: 'selectIndex=?', whereArgs: [id]);
  }
}
