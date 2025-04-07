import 'package:sqflite/sqlite_api.dart';

class DbServices{
  final Future<Database> db;
  DbServices({required this.db});

  ///fetch
  Future <List<Map<String, dynamic>>> getVocab({required String tbName, String? orderBy,String? where})async{
    Database database=await db;
    return await database.query(tbName,orderBy: orderBy,where: where);
  }

  ///insert to database
  Future <int> insert({required String tblName, required Map<String, dynamic> values,})async{
    Database database=await db;
    return await database.insert(tblName,values);
  }

  ///update to database
  Future <int> update({required  String tblName,required  Map<String, dynamic> values,required  String where,required List whereArgs})async{
    Database database=await db;
    return await database.update(tblName, values,where: where,whereArgs: whereArgs);
  }

  ///delete from data base
  Future <int> delete({required  String tblName,required  String where,required List whereArgs})async{
    Database database=await db;
    return await database.delete(tblName,where: where,whereArgs: whereArgs);
  }
}