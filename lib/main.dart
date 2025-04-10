import 'package:flutter/material.dart';
import 'package:vocabbook/layer/data/database/vocab_fields.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/locator.dart';
import 'layer/domain/bloc/design/design_cubit.dart';
import 'layer/presentation/my_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // تنظیم locator قبل از اجرای برنامه
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<VocabCubit>(create: (context) => VocabCubit()..fetchVocab(),),
          BlocProvider<DesignCubit>(create: (context) => DesignCubit()..setDesignCard(),),
        ],
        child: MyApp(),
      )
  );
}
