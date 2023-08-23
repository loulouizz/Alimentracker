import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB{
  //construtor com acesso privado
  DB._();
  //criar uma instância de db
  static final DB instance =  DB._();
  //criar instancia do sqlite
  static Database? _database;

  get database async{
    if(_database != null) return _database;
    return await _initDataBase();
  }

  _initDataBase() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'alimentracker.db'),
      version: 1,
      onCreate: onCreate,
    );
  }

  onCreate(db, versao) async {
    await db.execute(_meal);
  }

  String get _meal => '''
     CREATE TABLE meal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        calorias INTEGER,
        data DATE,
        horario TIME,
        conteudo TEXT
     )
  ''';
}