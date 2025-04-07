import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/domain/bloc/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/use_case/vocab_services.dart';
import 'package:vocabbook/locator.dart';

class AddVocabPage extends StatefulWidget {
  const AddVocabPage({super.key});

  @override
  State<AddVocabPage> createState() => _AddVocabPageState();
}

class _AddVocabPageState extends State<AddVocabPage> {
  final TextEditingController wordTxtController=TextEditingController();
  final TextEditingController meaningTxtController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConst.addVocab),),
      body: SafeArea(
          child: Padding(padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: wordTxtController,
                  decoration: InputDecoration(
                    label: Text("word")
                  ),
                ),
                TextField(
                  controller: meaningTxtController,
                  decoration: InputDecoration(
                    label: Text("meaning")
                  ),
                ),
                Spacer(),
                ElevatedButton(onPressed: (){
                  add();
                },
                    child: Text("add"))
              ],
            ),
          )),
    );
  }
  add()async{
    VocabServices vocabServices=locator<VocabServices>();
    String word=wordTxtController.text;
    String? meaning=meaningTxtController.text.isNotEmpty?wordTxtController.text:null;
    bool isInsert=await vocabServices.insert(word: word,meaning: meaning);
    if(isInsert && mounted){
      BlocProvider.of<VocabCubit>(context).fetchVocab();
      Navigator.pop(context);
    }
    else if(mounted){
      debugPrint("error in Insert Data");
    }
  }
}
