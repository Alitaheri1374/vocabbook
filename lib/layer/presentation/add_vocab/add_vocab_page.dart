import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/domain/use_case/vocab_services.dart';
import 'package:vocabbook/locator.dart';
import 'package:file_picker/file_picker.dart';


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
  ///description Controller
  final TextEditingController descriptionTxtController=TextEditingController();

  late VocabStatus vocabStatus;
  Uint8List? byte;

  final GlobalKey<FormState> formKey=GlobalKey<FormState>();
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
      byte=widget.vocabModel?.image;
      if(mounted){
        setState(() {

        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(title: Text(AppConst.addVocab),),
        body: SafeArea(
            child: Padding(padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    TextFormField(
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
                    Column(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(byte!=null)
                          Image.memory(
                            byte!,
                            width: MediaQuery.sizeOf(context).width*.3,
                            height: MediaQuery.sizeOf(context).height*.2,
                            fit: BoxFit.cover,
                          ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: pickImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    spacing: 5,
                                    children: [
                                      Icon(Icons.image,color: Colors.white,),
                                      Text("Select Image",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                )),
                            if(byte!=null)
                            ElevatedButton(onPressed: removeImage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    spacing: 5,
                                    children: [
                                      Icon(CupertinoIcons.trash,color: Colors.white,),
                                      Text("Remove Image",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    TextField(
                      controller: descriptionTxtController,
                      minLines: 1,
                      maxLines: 6,
                      decoration: InputDecoration(
                          label: Text("description"),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        bottomNavigationBar: InkWell(onTap: (){
          task();
        },
            child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 65,
                color: Theme.of(context).primaryColor,
                child: Center(child: Text(widget.vocabModel!=null?"Save":"Add",
                  style: Theme.of(context).textTheme.titleMedium,
                )))),
      ),
    );
  }


  void pickImage () async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      withData: true
    );
    if(result!=null && result.files.isNotEmpty && mounted){
      setState(() {
        byte=result.files[0].bytes;
      });
    }
  }

  void removeImage(){
    setState(() {
      byte=null;
    });
  }

  task(){
    if (formKey.currentState!.validate()) {
      if(widget.vocabModel!=null){
        edit();
      }
      else{
        add();
      }
    }
  }

  add()async{
    VocabServices vocabServices=locator<VocabServices>();
    String word=wordTxtController.text.trim();
    String? meaning=meaningTxtController.text.isNotEmpty?meaningTxtController.text.trim():null;
    String? description=descriptionTxtController.text.isNotEmpty?descriptionTxtController.text.trim():null;
    bool isInsert=await vocabServices.insert(word: word,meaning: meaning,status:vocabStatus,
      image: byte,
      description: description
    );
    if(isInsert && mounted){
      changeSuccess();
    }
    else if(mounted){
      debugPrint("error in Insert Data");
    }
  }
  edit()async{
    VocabServices vocabServices=locator<VocabServices>();
    String word=wordTxtController.text.trim();
    String? meaning=meaningTxtController.text.isNotEmpty?meaningTxtController.text.trim():null;

    String? description=descriptionTxtController.text.isNotEmpty?descriptionTxtController.text.trim():null;
    bool isUpdate=await vocabServices.update(
        id:widget.vocabModel!.id,
        word: word,meaning: meaning,
        status: vocabStatus,
        typeWord: widget.vocabModel?.typeWord,
        isFavorite: widget.vocabModel?.isFavorite,createdTime: widget.vocabModel?.createdTime,
        image: byte,
        description: description
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
