import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/domain/use_case/vocab_services.dart';
import 'package:vocabbook/locator.dart';

class AddVocabPage extends StatefulWidget {
  final VocabModel? vocabModel;
  const AddVocabPage({super.key,this.vocabModel});

  @override
  State<AddVocabPage> createState() => _AddVocabPageState();
}

class _AddVocabPageState extends State<AddVocabPage> {
  ///word Controller
  final TextEditingController wordTxtController=TextEditingController();
  ///meaning Controller
  final TextEditingController meaningTxtController=TextEditingController();

  late VocabStatus vocabStatus;
  @override
  void initState() {
    super.initState();
    vocabStatus=widget.vocabModel?.status??VocabStatus.hard;
    if(widget.vocabModel!=null){
      initField();
    }
  }


  void initField(){
      wordTxtController.text=widget.vocabModel?.word??'';
      meaningTxtController.text=widget.vocabModel?.meaning??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConst.addVocab),),
      body: SafeArea(
          child: Padding(padding: EdgeInsets.all(10),
            child: Column(
              spacing: 10,
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
                Row(
                  spacing: 5,
                  children: VocabStatus.values.map((e) =>
                  FilterChip(
                    color: WidgetStatePropertyAll(
                        e==VocabStatus.hard?Colors.red:
                        e==VocabStatus.normal?Colors.yellow:
                        e==VocabStatus.easy?Colors.green:
                        Colors.grey
                    ),
                    label:
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(e==vocabStatus)
                        Icon(Icons.check),
                        Text(e.name,style: TextStyle(color:
                        e==vocabStatus?Colors.white:Colors.black)),
                      ],
                    ),

                    onSelected: (value){
                      setState(() {
                        vocabStatus=e;
                      });
                    },),
                  ).toList(),
                ),
                Spacer(),
                ElevatedButton(onPressed: (){
                  task();
                },
                    child: Text(widget.vocabModel!=null?"save":"add"))
              ],
            ),
          )),
    );
  }

  task(){
    if(widget.vocabModel!=null){
      edit();
    }
    else{
      add();
    }
  }

  add()async{
    VocabServices vocabServices=locator<VocabServices>();
    String word=wordTxtController.text;
    String? meaning=meaningTxtController.text.isNotEmpty?meaningTxtController.text:null;
    bool isInsert=await vocabServices.insert(word: word,meaning: meaning,status:vocabStatus);
    if(isInsert && mounted){
      changeSuccess();
    }
    else if(mounted){
      debugPrint("error in Insert Data");
    }
  }
  edit()async{
    VocabServices vocabServices=locator<VocabServices>();
    String word=wordTxtController.text;
    String? meaning=meaningTxtController.text.isNotEmpty?meaningTxtController.text:null;
    bool isUpdate=await vocabServices.update(
        id:widget.vocabModel!.id,
        word: word,meaning: meaning,
        status: vocabStatus,
        typeWord: widget.vocabModel?.typeWord,
        isFavorite: widget.vocabModel?.isFavorite,createdTime: widget.vocabModel?.createdTime
    );
    if(isUpdate && mounted){
      changeSuccess();
    }
    else if(mounted){
      debugPrint("error in edit Data");
    }
  }
  void changeSuccess(){
    BlocProvider.of<VocabCubit>(context).fetchVocab();
    Navigator.pop(context);
  }

}
