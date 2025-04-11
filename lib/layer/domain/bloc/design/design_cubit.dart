import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'design_state.dart';

class DesignCubit extends Cubit<DesignState> {
  DesignCubit() : super(DesignInitial());
  
  void toggle(){
    if(state is DesignCard){
      setDesignList();
    }else{
      setDesignCard();
    }
  }
  void setDesignList(){emit(DesignList());}
  void setDesignCard(){emit(DesignCard());}
}
