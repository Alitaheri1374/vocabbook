import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/constants/app_const.dart';
import 'package:vocabbook/layer/domain/bloc/design/design_cubit.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/presentation/add_vocab/add_vocab_page.dart';
import 'package:vocabbook/layer/presentation/home_page/body.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DesignCubit, DesignState>(
        builder: (context, stateDesign) {
        return BlocBuilder<VocabCubit, VocabState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(AppConst.appbarTitle),
                actions: [
                  if(state is VocabDataState && state.data.isNotEmpty)
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      BlocProvider.of<DesignCubit>(context).toggle();
                    },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        stateDesign is DesignList?
                            CupertinoIcons.list_bullet_below_rectangle:
                            Icons.list
                      ),
                    ),
                  ),
                )],
              ),
              body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(
                        builder: (context, bx) {
                          return SizedBox(
                            width: bx.maxWidth,
                            height: bx.maxHeight,
                            child:
                            state is VocabLoadingState ?
                            Center(child: CircularProgressIndicator(),) :
                            state is VocabErrorState ?
                            Center(child: TextButton(onPressed: () {
                              BlocProvider.of<VocabCubit>(context).fetchVocab();
                            }, child: Text("Try Again")),) :

                            state is VocabDataState ?
                            HomeBody() :
                            Container(),
                          );
                        }
                    ),
                  )),
              floatingActionButton: FloatingActionButton(onPressed: () {
                Route route = MaterialPageRoute(
                  builder: (context) => AddVocabPage(),);
                Navigator.push(context, route);
              },
                child: Icon(Icons.add),

              ),
            );
          },
        );
      },
    );
  }


}
