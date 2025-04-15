class VocabFields{
  static const String tblName="user_vocab_tbl";
  static const String tblPrimaryKey="id";
  static const String tblOrderKey="createdTime";
  static const Map<String,String>valuesField={
    tblPrimaryKey:"INTEGER PRIMARY KEY AUTOINCREMENT",
    "word":"TEXT NOT NULL",
    "meaning":"TEXT",
    "typeWord":"INTEGER",
    "status":"INTEGER",
    "isFavorite":"INTEGER NOT NULL",
    "image":"BLOB",
    "description":"TEXT",
    tblOrderKey:"TEXT NOT NULL",
    "updateTime":"TEXT",
  };

  static  String crateTblQuery(){
    String queryField='';
    valuesField.forEach((key, value) =>
    queryField="${queryField.isNotEmpty?"$queryField,":""}$key $value",);
    return "Create Table ${VocabFields.tblName} ($queryField)";
  }

}