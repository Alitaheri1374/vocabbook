class VocabModel{
  final int? id;
  ///کلمه
  final String word;
  ///معنی
  final String? meaning;
  final int? typeWord;
  final int? status;
  final bool? isFavorite ;
  final String? createdTime;
  final String? updateTime;

  VocabModel({this.id,required this.word,this.meaning,this.typeWord,this.status,this.isFavorite,this.createdTime,this.updateTime});

  factory VocabModel.fromJson(Map<String,dynamic>json)=> VocabModel(
        id: json['id'],
        word: json['word'],
        meaning: json['meaning'],
        typeWord: json['typeWord'],
        status: json['status'],
        isFavorite : json['isFavorite '],
        createdTime: json['createdTime'],
        updateTime: json['updateTime'],
    );

  Map<String,dynamic> toJson ()=>
   {
    "id": id,
    "word": word,
    "meaning": meaning,
    "typeWord": typeWord,
    "status": status,
    "isFavorite" : isFavorite==true?1:0,
    "createdTime": createdTime,
    "updateTime": updateTime,
    };

}
