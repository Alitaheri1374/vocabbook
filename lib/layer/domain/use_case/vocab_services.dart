import 'package:vocabbook/layer/domain/repository/vocab_repository.dart';

import '../entity/vocab_model.dart';

class VocabServices{
  final VocabRepository vocabRepository;

  VocabServices({required this.vocabRepository});

  Future<List<VocabModel>>get()async{
    return await vocabRepository.get();
  }

  Future<bool>insert({required String word,String? meaning})async{
    VocabModel vocab=VocabModel(word: word,meaning: meaning,typeWord: 0,status: 0,isFavorite: false,createdTime: DateTime.now().toString());
    int isInsert= await vocabRepository.insert(vocab: vocab);
    return isInsert!=-1;
  }

  Future<bool>update({required  int? id,    required  String word,    required  String? meaning,    required  int? typeWord,
    required  int? status,    required  bool? isFavorite,    required  String? createdTime,
  })async{
    VocabModel vocab=VocabModel(id:id,word:word,meaning:meaning,typeWord:typeWord,status:status,isFavorite:isFavorite,createdTime:createdTime,updateTime: DateTime.now().toString());
    int isUpdate= await vocabRepository.update(vocab: vocab);
    return isUpdate!=-1;
  }

  Future<bool>delete({required VocabModel vocab})async{
    int isDelete= await vocabRepository.delete(vocab: vocab);
    return isDelete!=-1;
  }
}