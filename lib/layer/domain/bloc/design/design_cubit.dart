import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'design_state.dart';

class DesignCubit extends Cubit<DesignState> {
  DesignCubit() : super(DesignInitial());
  
  void setDesignList(){emit(DesignList());}
  void setDesignCard(){emit(DesignCard());}
}
