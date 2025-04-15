import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart' show CardSwiper;
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';

import '../boyd_controller.dart';

class VocabDesignCard extends StatefulWidget {
  const VocabDesignCard({super.key});

  @override
  State<VocabDesignCard> createState() => _VocabDesignCardState();
}

class _VocabDesignCardState extends BodyController<VocabDesignCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabCubit, VocabState>(
        builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: CardSwiper(
                cardsCount: (state as VocabDataState).data.length,
                numberOfCardsDisplayed: (state.data.length)>1?2:1,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  return Align(
                    alignment: Alignment.center,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        // gradient: LinearGradient(colors: getGradient(state.data[index].status!),
                        gradient: LinearGradient(colors:
                         getGradientBaseStatus(state.data[index].status!,index),
                        // gradient: LinearGradient(colors: getGradientBaseIndex(index),
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        // boxShadow: [
                        //   BoxShadow(color: Colors.grey,offset: Offset(1, 4))
                        // ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                        child: Column(
                          spacing: 5,
                          children: [
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context,bx) {
                                  return SizedBox(
                                    height: bx.maxHeight,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        spacing: 5,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    color: state.data[index].status==VocabStatus.normal?Colors.white:Colors.yellow,
                                                    icon: const Icon(Icons.edit),
                                                    onPressed: () {
                                                      isEditTask(state.data[index]);
                                                    },
                                                  ),
                                                  IconButton(
                                                    color: state.data[index].status==VocabStatus.hard?
                                                      Colors.orangeAccent:
                                                    Colors.red,
                                                    icon: const Icon(Icons.delete),
                                                    onPressed: () {
                                                      isDeleteTask(state.data[index]);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    isFavoriteTask(state.data[index]);
                                                  },
                                                  color: state.data[index].isFavorite?(
                                                      Colors.white):Colors.grey,
                                                  icon: Icon(
                                                    state.data[index].isFavorite?
                                                    Icons.favorite:
                                                    Icons.favorite_border,
                                                  )),
                                            ],
                                          ),
                                          Text(state.data[index].word,
                                            style: Theme.of(context).textTheme.headlineLarge,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(state.data[index].meaning??'',
                                                style: Theme.of(context).textTheme.headlineMedium,
                                              )
                                          ),
                                          SizedBox(height: 15,),
                                          if(state.data[index].image!=null)
                                            Center(
                                              child: Image.memory(
                                                state.data[index].image!,
                                                width: bx.maxWidth*.8,
                                                height: bx.maxHeight*.5,
                                                fit: BoxFit.scaleDown,
                                                                          ),
                                            ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.data[index].description!=null &&
                                              state.data[index].description!.isNotEmpty?
                                              ('description : \n${state.data[index].description!}')
                                                  :'',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                            Row(
                              spacing: 5,
                              children: VocabStatus.values.map((e) =>
                                  FilterChip(
                                    color: WidgetStatePropertyAll(
                                      getColorBaseStatusItem(e),),
                                    label:
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if(e==state.data[index].status)
                                          Icon(Icons.check),
                                        Text(e.name,style: TextStyle(color:
                                        e==state.data[index].status?Colors.white:Colors.black),),
                                      ],
                                    ),
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
                      )
                    ),
                  );
                },
              ),
            );
          },
        );
      }
    );
  }
}
