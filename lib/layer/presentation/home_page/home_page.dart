import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/domain/bloc/vocab_cubit.dart';
import 'package:vocabbook/layer/presentation/add_vocab/add_vocab_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabCubit, VocabState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(AppConst.appbarTitle),),
          body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(
                    builder: (context, bx) {
                      return SizedBox(
                        width: bx.maxWidth,
                        height: bx.maxHeight,
                        child: 
                        state is VocabLoadingState?
                          Center(child: CircularProgressIndicator(),):
                        state is VocabErrorState?
                          Center(child: TextButton(onPressed: () {
                            BlocProvider.of<VocabCubit>(context).fetchVocab();
                          }, child: Text("Try Again")),):

                        state is VocabDataState?
                        ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(state.data[index].word)
                                ],
                              ),
                            );
                          },):
                        Container(),
                      );
                    }
                ),
              )),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Route route = MaterialPageRoute(
              builder: (context) => AddVocabPage(),);
            Navigator.push(context, route);
            Navigator.push(context, route);
          },),
        );
      },
    );
  }
}
