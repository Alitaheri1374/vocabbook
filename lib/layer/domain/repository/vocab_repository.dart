import 'package:vocabbook/layer/data/database/vocab_fields.dart';
import 'package:vocabbook/layer/data/db_services.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';

class VocabRepository{
  final DbServices dbServices;
  final String tblName;
  final String tblPrimaryKey;
  final String tblOrderKey;
  VocabRepository({required this.dbServices,this.tblName= VocabFields.tblName,this.tblPrimaryKey= VocabFields.tblPrimaryKey,
    this.tblOrderKey= VocabFields.tblOrderKey});

  ///get vocab
  Future<List<VocabModel>> get({String? orderBy,String? where})async{
    List<Map<String, dynamic>> result=await dbServices.getVocab(tbName: tblName,orderBy: orderBy??"$tblOrderKey desc", where: where);
    return result.map((e) => VocabModel.fromJson(e),).toList();
  }
  ///insert vocab
  Future<int> insert({required VocabModel vocab})async{
    Map<String,dynamic> json=vocab.toJson();
    // print(json);
    return await dbServices.insert(tblName: tblName,values: json);
  }
  ///update vocab
  Future<int> update({required VocabModel vocab})async{
    Map<String,dynamic> json=vocab.toJson();
    // print(json);
    return await dbServices.update(tblName: tblName,values: json,where: '$tblPrimaryKey= ?',whereArgs: [vocab.id]);
  }
  ///delete vocab
  Future<int> delete({required VocabModel vocab})async{
    return await dbServices.delete(tblName: tblName,where: '$tblPrimaryKey= ?',whereArgs: [vocab.id]);
  }

}