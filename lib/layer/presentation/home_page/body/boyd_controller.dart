import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/presentation/add_vocab/add_vocab_page.dart';
class BodyController <T  extends StatefulWidget> extends State<T>{

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  ///
  Color getColorBaseStatusItem(VocabStatus status){
    return
    status==VocabStatus.hard?Colors.red:
    status==VocabStatus.normal?Colors.yellow:
    status==VocabStatus.easy?Colors.green:
    Colors.grey;
  }

  List<Color>getGradient(VocabStatus status){
    List<Color> data=[];
    data.add(getColorBaseStatusItem(status));
    for (var e in VocabStatus.values) {
      if(e!=status){
        data.add(VocabStatus.hard==e?Colors.red:
        VocabStatus.normal==e?Colors.yellow:
        Colors.green);
      }
    }
    return data;
  }

  ///isFavorite
  isFavoriteTask(VocabModel model)async{
    BlocProvider.of<VocabCubit>(context).isFavoriteItem(model);
  }

  ///isFavorite
  isChangeStatusTask(VocabModel model,VocabStatus status)async{
    BlocProvider.of<VocabCubit>(context).isChangeStatusItem(model,status);
  }

  ///delete
  isDeleteTask(VocabModel model)async{
    BlocProvider.of<VocabCubit>(context).isDeleteItem(model);
  }
  ///edit
  isEditTask(VocabModel model)async{
    Route route=MaterialPageRoute(builder: (context) => AddVocabPage(
      vocabModel: model,
    ),);
    Navigator.push(context, route);
  }

}