import 'dart:math';

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
    switch(status){
      case (VocabStatus.hard):
        return Colors.red;
      case (VocabStatus.normal):
        return Colors.yellow;
      case (VocabStatus.easy):
        return Colors.green;
      default:
        return Colors.grey;
    }
  }


  List<Color> getGradientBaseStatus(VocabStatus status,int index){
    switch(status){
      case (VocabStatus.easy):
        return getGradientEasyState(index);
      case (VocabStatus.normal):
        return getGradientNormalState(index);
      case (VocabStatus.hard):
        return getGradientHardState(index);
      default:
        return getGradientEasyState(index);
    }
  }

  ///gradient Easy
  List<Color>getGradientEasyState(int index){
    List<List<Color> >data=[
      [
        Color(0xFF0D1E12), // سبز بسیار تیره (مشبیه به سیاه)
        Color(0xFF1E3A1E), // سبز جنگلی تیره
        Color(0xFF2D5A2D), // سبز متوسط
        Color(0xFF00CC00),
      ],
      [
        Color(0xFF092E20), // سبز تیره
        Color(0xFF1A4A3A), // سبز-آبی
        Color(0xFF2C786C), // آبی-سبز (Teal)
        Color(0xFF00CC00),
      ],
      [
        Color(0xFF003D00), // سبز تیره
        Color(0xFF008000), // سبز استاندارد
        Color(0xFF00CC00), // سبز نئونی
      ],
      [
        Color(0xFF1A2E1A), // سبز-خاکستری تیره
        Color(0xFF3A4A3A), // سبز-خاکستری
        Color(0xFF00CC00),
      ],
      [
        Color(0xFF0A2E1D), // سبز تیره
        Color(0xFF1A5A3A), // سبز زمردی تیره
        Color(0xFF2E8B57), // سبز زمردی (Emerald)
        Color(0xFF00CC00),
      ],
      [
        Color(0xFF1E3A1A), // سبز تیره
        Color(0xFF4A6B3A), // سبز-زیتونی
        Color(0xFFD4AF37), // طلایی (به عنوان هایلایت)
        Color(0xFF00CC00),
      ],
      [
        Color(0xFF0F1A0F), // نزدیک به مشکی
        Color(0xFF1E3A1E), // سبز تیره
        Color(0xFF2D5A2D), // سبز متوسط
        Color(0xFF00CC00),
      ],
    ];
    // Random random = Random();
    // int index=random.nextInt(data.length);
    // return data[index];
    return data[(index%data.length)];
  }
  ///gradient Normal
  List<Color>getGradientNormalState(int index){
    List<List<Color> >data=[
      [
        Color(0xFF332900), // زرد بسیار تیره (نزدیک به مشکی)
        Color(0xFF665200), // زرد طلایی تیره
        Color(0xFF997B00), // زرد طلایی متوسط
        Colors.yellow,
      ],
      [
        Color(0xFF3A3A00), // زرد-خاکستری تیره
        Color(0xFF5C5C00), // زرد-خاکستری
        Color(0xFF7D7D00), // زرد مات
        Colors.yellow,
      ],
      [
        Color(0xFF4D3D00), // زرد تیره
        Color(0xFF775F02), // زرد تیره
        Color(0xFF8C6D00), // زرد کهربایی
        Color(0xFFCC9C00), // زرد روشن‌تر
        Colors.yellow,
      ],
      [
        Color(0xFF2E2C00), // زرد-سبز بسیار تیره
        Color(0xFF5A5700), // زرد زیتونی
        Color(0xFF868300), // زرد-سبز روشن
        Colors.yellow,
      ],
      [
        Color(0xFF000000), // مشکی
        Color(0xFF332E00), // زرد تیره
        Color(0xFF665C00), // زرد طلایی
        Colors.yellow,
      ],
      [
        Color(0xFF3A3200), // زرد-قهوه‌ای تیره
        Color(0xFF756400), // زرد خاکی
        Color(0xFFB09700), // زرد روشن
        Colors.yellow,
      ],
      [
        Color(0xFF1A1A00), // مشکی-زرد
        Color(0xFF4D4D00), // زرد تیره
        Color(0xFFCCCC00), // زرد نئونی (به عنوان هایلایت)
        Colors.yellow,
      ],
    ];
    return data[(index%data.length)];
  }
  ///gradient Hard
  List<Color>getGradientHardState(int index){
    List<List<Color> >data=[
      [
        Color(0xFF1A0000), // مشکی متمایل به قرمز
        Color(0xFF4D0000), // قرمز تیره
        Color(0xFF800000), // قرمز شرابی (Maroon)
        Colors.red
      ],
      [
        Color(0xFF2D0000), // قرمز بسیار تیره
        Color(0xFF6A0000), // زرشکی تیره
        Color(0xFFA80000), // قرمز زرشکی
        Colors.red
      ],
      [
        Color(0xFF3A0000), // قرمز-قهوه‌ای تیره
        Color(0xFF6B0000), // قرمز آجری
        Color(0xFF9C0000), // قرمز سوخته
        Colors.red
      ],
      [
        Color(0xFF28001A), // بنفش-قرمز تیره
        Color(0xFF520038), // مخملی
        Color(0xFF7D0055), // قرمز-بنفش
        Colors.red
      ],
      [
        Color(0xFF330000), // قرمز تیره
        Color(0xFF660000), // قرمز متوسط
        Color(0xFFCC3300), // نارنجی-قرمز (هایلایت)
        Colors.red
      ],
      [
        Color(0xFF3D0000), // قرمز تیره
        Color(0xFF7A0000), // قرمز-صورتی تیره
        Color(0xFFB8004B), // صورتی-قرمز
        Colors.red
      ],
      [
        Color(0xFF2A1E1E), // خاکستری-قرمز تیره
        Color(0xFF4A2E2E), // قرمز مات
        Color(0xFF6B3E3E), // قرمز-خاکستری
        Colors.red
      ],
    ];
    return data[(index%data.length)];
  }
  ///gradient base index
  List<Color>getGradientBaseIndex(int index){
    List<List<Color> >data=[
      [
        Color(0xFF093028), // سبز-آبی خیلی تیره
        Color(0xFF237A57), // سبز تیره
      ],
      [
        Color(0xFF4B1248), // بنفش تیره
        Color(0xFF651661), // بنفش تیره
        Color(0xFFB91FAD), // بنفش تیره
        Color(0xFFEE07DD), // بنفش تیره
        Color(0xFFF0C27B), // طلایی-صورتی
      ],
      [
        Color(0xFF0F2027), // تاریک آبی
        Color(0xFF203A43), // آبی متوسط
        Color(0xFF2C5364), // آبی روشن‌تر
        Color(0xFF07A6EF),
      ],
      [
        Color(0xFF870000), // قرمز تیره
        Color(0xFF190A05), // مشکی
      ],
      [
        Color(0xFF1D2B32), // سبز-آبی تیره
        Color(0xFF2E3E4A), // آبی-خاکستری
      ],
      [
        Color(0xFF000000), // مشکی
        Color(0xFF434343), // خاکستری تیره
      ],
    ];


    return data[(index%data.length)];
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