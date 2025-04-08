part 'vocab_status.dart';
class VocabModel{
  int? id;
  ///کلمه
  String word;
  ///معنی
  String? meaning;
  ///نوع کلمه
  int? typeWord;
  ///وضعیت
  VocabStatus? status;
  bool isFavorite ;
  String? createdTime;
  String? updateTime;

  VocabModel({this.id,required this.word,this.meaning,this.typeWord,this.status,this.isFavorite=false,this.createdTime,this.updateTime});

  factory VocabModel.fromJson(Map<String,dynamic>json)=> VocabModel(
        id: json['id'],
        word: json['word'],
        meaning: json['meaning'],
        typeWord: json['typeWord'],
        status: json['status']==2?VocabStatus.hard:json['status']==1?VocabStatus.normal:VocabStatus.easy,
        isFavorite : json['isFavorite']==1?true:false,
        createdTime: json['createdTime'],
        updateTime: json['updateTime'],
    );

  Map<String,dynamic> toJson ()=>
   {
    "id": id,
    "word": word,
    "meaning": meaning,
    "typeWord": typeWord,
    "status": status==VocabStatus.hard?2:status==VocabStatus.normal?1:0,
    "isFavorite" : isFavorite==true?1:0,
    "createdTime": createdTime,
    "updateTime": updateTime,
    };

}
