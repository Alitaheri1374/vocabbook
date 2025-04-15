import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/presentation/shared_component/slide_menu_widget.dart';

import '../shared_component/slide_menu_widget.dart';

class ShowVocabItem extends StatefulWidget {
  const ShowVocabItem({super.key});

  @override
  State<ShowVocabItem> createState() => _ShowVocabItemState();
}

class _ShowVocabItemState extends State<ShowVocabItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabCubit, VocabState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if(state is VocabDataState){

              if (state.data.isEmpty) {
                return Center(child: Text("Empty"),);
              }else{
                return  ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                          position: DecorationPosition.background,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color:
                              state.data[index].status==VocabStatus.hard?Colors.red:
                              state.data[index].status==VocabStatus.normal?Colors.yellow:
                              state.data[index].status==VocabStatus.easy?Colors.green:
                              Colors.grey ,
                                // offset: Offset(-10, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8)
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 2,bottom: 1,),
                          child: DecoratedBox(
                            position: DecorationPosition.background,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8),
                                backgroundBlendMode: BlendMode.clear,
                                boxShadow: [
                                  BoxShadow(color: Colors.grey,offset: Offset(0, 1.2)),
                                  BoxShadow(color: Theme.of(context).cardColor,offset: Offset(1, -1),blurRadius: 0),
                                ]
                            ),
                            child: SlideMenu(
                              menuItems: <Widget>[
                                Container(
                                  color: Colors.black12,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  color: Colors.red,
                                  child: IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                              child: InkWell(
                                // color: Colors.transparent,
                                // margin: EdgeInsets.zero,
                                // shadowColor: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.data[index].word),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(state.data[index].meaning??''))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
           
            }
            else{
              return Center();
            }
          },
        );
      },
    );
  }
}
