import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/presentation/add_vocab/add_vocab_page.dart';
import 'package:vocabbook/layer/presentation/shared_component/slide_menu_widget.dart';

import '../boyd_controller.dart';


class VocabDesignList extends StatefulWidget {
  const VocabDesignList({super.key});

  @override
  State<VocabDesignList> createState() => _VocabDesignListState();
}

class _VocabDesignListState extends BodyController<VocabDesignList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabCubit, VocabState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
                return  ListView.builder(
                  itemCount: (state as VocabDataState).data.length,
                  itemBuilder: (context, index) {
                    return SlideMenu(
                      menuItems: <Widget>[
                        IconButton(
                          color: Colors.yellow,
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            isEditTask(state.data[index]);
                          },
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            isDeleteTask(state.data[index]);
                          },
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
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Text(state.data[index].word,
                                        style: Theme.of(context).textTheme.titleMedium,
                                        )),
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
                                        child: Text(state.data[index].meaning??'',
                                        style: Theme.of(context).textTheme.labelLarge,
                                        )
                                    ),
                                    if(state.data[index].description!=null &&
                                        state.data[index].description!.isNotEmpty)
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(state.data[index].description??'',
                                          style: Theme.of(context).textTheme.labelSmall,
                                        )
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
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            (state.data[index].updateTime??
                                                state.data[index].createdTime??'').split('.')[0]
                                        ),

                                        Icon(
                                            state.data[index].updateTime!=null?
                                            CupertinoIcons.time_solid:
                                            CupertinoIcons.time
                                        ),
                                      ],
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
          },
        );
      },
    );
  }

}
