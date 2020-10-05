import 'package:bloc/bloc.dart';
import 'package:flutter_app/modules/check/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckCubit extends Cubit<CheckStates>
{
  CheckCubit() : super(InitialCheckState());

  static CheckCubit get (context) => BlocProvider.of(context);

  bool chocolate = false;
  bool mocca = false;

  checkChocolate(chocolateNewValue)
  {
    chocolate = chocolateNewValue;
    emit(ChocolateCheckState());
  }

  checkMocca(moccaNewValue)
  {
    mocca = moccaNewValue;
    emit(MoccaCheckState());
  }
}