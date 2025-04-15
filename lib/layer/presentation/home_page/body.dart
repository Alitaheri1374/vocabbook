import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:vocabbook/layer/domain/bloc/design/design_cubit.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/domain/bloc/vocab/vocab_cubit.dart';
import 'package:vocabbook/layer/presentation/home_page/body/card/vocab_card_design.dart';

import 'body/list/vocab_list_design.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VocabCubit, VocabState>(
      builder: (context, stateDate) {
        return BlocBuilder<DesignCubit, DesignState>(
          builder: (context, state) {
            if ((stateDate as VocabDataState).data.isEmpty) {
              return Center(child: Text("Empty"),);
            }
            else if (state is DesignCard) {
              return VocabDesignCard();
            }
            else if (state is DesignList) {
              return VocabDesignList();
            }
            else {
              return Container();
            }
          },
        );
      },
    );
  }
}
