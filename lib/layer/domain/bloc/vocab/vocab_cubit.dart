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

  ///favorite item
  void isFavoriteItem(VocabModel model)async{
    bool isFavorite=!(model.isFavorite);
    VocabServices vocabServices=locator<VocabServices>();
    bool isUpdate=await vocabServices.update(id: model.id, word: model.word, meaning: model.meaning,
        typeWord: model.typeWord, status: model.status,
        image: model.image,description: model.description,
        isFavorite: isFavorite, createdTime: model.createdTime);
    if(state is VocabDataState && isUpdate){
      int indexActive=(state as VocabDataState).data.indexOf(model);
      (state as VocabDataState).data[indexActive].isFavorite=isFavorite;
      emit(VocabDataState(data: (state as VocabDataState).data));
    }
  }

  ///favorite item
  void isChangeStatusItem(VocabModel model,VocabStatus status)async{
    bool isFavorite=!(model.isFavorite);
    VocabServices vocabServices=locator<VocabServices>();
    bool isUpdate=await vocabServices.update(id: model.id, word: model.word, meaning: model.meaning,
        typeWord: model.typeWord, status: status,
        image: model.image,description: model.description,
        isFavorite: isFavorite, createdTime: model.createdTime);
    if(state is VocabDataState && isUpdate){
      int indexActive=(state as VocabDataState).data.indexOf(model);
      (state as VocabDataState).data[indexActive].status=status;
      emit(VocabDataState(data: (state as VocabDataState).data));
    }
  }

  ///Delete item
  void isDeleteItem(VocabModel model)async{
    VocabServices vocabServices=locator<VocabServices>();
    bool isDelete=await vocabServices.delete(vocab: model);
    if(state is VocabDataState && isDelete){
      // int indexActive=(state as VocabDataState).data.indexWhere((element) => element.id==model.id,);
      // (state as VocabDataState).data.removeAt(indexActive);
      (state as VocabDataState).data.remove(model);
      emit(VocabDataState(data: (state as VocabDataState).data));
    }
  }
}

