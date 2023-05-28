import 'package:sqflite/sqflite.dart';
import 'package:swipe_me/dbhelper/db2.dart';
import 'package:swipe_me/model/cont2model.dart';

class Repository2 {
  late Dphelper2 _dphelper2;
  Repository2() {
    _dphelper2 = Dphelper2();
  }
  static Database? _database;
  Future<Database?> getAlldb() async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dphelper2.setdb2();
    }
    return null;
  }

  Future<void> insertsave(Cont2model cont2model) async {
    await getAlldb();
    var db = _database;
    await db?.insert('book2', cont2model.toMap());
    await db!.rawQuery('SELECT * FROM book2');
  }

  Future<List<Cont2model>> getimage2() async {
    await getAlldb();
    var db = _database;
    var data = await db!.rawQuery("SELECT * FROM  book2");

    //
    return List<Cont2model>.from(data.map((e) => Cont2model.fromMap(e)));
  }

  delete(id) async {
    var db = _database;
    var delete =
        await db!.delete('book2', where: 'imageUrl=?', whereArgs: [id]);
    print(delete);
    return delete;
  }
}
