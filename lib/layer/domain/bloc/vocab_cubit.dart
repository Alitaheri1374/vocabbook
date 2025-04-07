import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vocabbook/layer/domain/entity/vocab_model.dart';
import 'package:vocabbook/layer/domain/use_case/vocab_services.dart';
import 'package:vocabbook/locator.dart';

part 'vocab_state.dart';

class VocabCubit extends Cubit<VocabState> {
  VocabCubit() : super(VocabInitial());

  void fetchVocab()async{
    emit(VocabLoadingState());
    VocabServices vocabServices=locator<VocabServices>();
    List<VocabModel> data=await vocabServices.get();
    emit(VocabDataState(data: data));
  }

}
