import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/layer/domain/bloc/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/domain/use_case/vocab_services.dart';
import 'package:vocabbook/layer/presentation/shared_component/slide_menu_widget.dart';
import 'package:vocabbook/locator.dart';

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
                    return SlideMenu(
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
                            onPressed: () {
                              isDeleteTask(state.data[index]);
                            },
                          ),
                        ),
                      ],
                      child: Card(
                        // color: Colors.transparent,
                        margin: EdgeInsets.all(5),
                        elevation: 5,
                        shadowColor: Colors.grey.withValues(alpha: .3),
                        child: DecoratedBox(
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
                            padding: const EdgeInsets.only(left: 2,),
                            child: DecoratedBox(
                              // position: DecorationPosition.background,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Text(state.data[index].word)),
                                        IconButton(onPressed: () {
                                          isFavoriteTask(state.data[index]);
                                        },
                                        color: state.data[index].isFavorite?Colors.red:Colors.grey,
                                        icon: Icon(
                                            state.data[index].isFavorite?
                                            Icons.favorite:
                                            Icons.favorite_border,
                                        ))
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(state.data[index].meaning??'')
                                    ),
                                    Row(
                                      spacing: 5,
                                      children: VocabStatus.values.map((e) =>
                                      e==state.data[index].status?
                                          Container():
                                      FilterChip(
                                        color: WidgetStatePropertyAll(
                                            e==VocabStatus.hard?Colors.red:
                                            e==VocabStatus.normal?Colors.yellow:
                                            e==VocabStatus.easy?Colors.green:
                                            Colors.grey
                                        ),
                                        label: Text(e.name),
                                        onSelected: (value) =>
                                            isChangeStatusTask(state.data[index], e),),
                                      ).toList(),
                                    )
                                  ],
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
}
