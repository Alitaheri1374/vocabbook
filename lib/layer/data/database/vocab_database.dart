//dateBase Vocab
import 'dart:async';
import "package:path/path.dart" show join;
import 'package:sqflite/sqflite.dart';
import 'vocab_fields.dart';
class VocabDatabase{
  static Database? _database;

  Future<Database> get database async{
    if(_database!=null){
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase()async{
    String path=await getDateBasePath();
    return await openDatabase(
      path,
      version: 1,
      onCreate:_onCreateDatabase
    );
  }


  FutureOr <void>_onCreateDatabase(Database db,int version)async{
    return await db.execute('''
      ${VocabFields.crateTblQuery()}
    ''');
  }

  Future<String> getDateBasePath()async{
    String databasePath=await getDatabasesPath();
    String path = join(databasePath, 'vocab.db');
    // String path = (databasePath+ '/vocab.db');
    return path;
  }
}