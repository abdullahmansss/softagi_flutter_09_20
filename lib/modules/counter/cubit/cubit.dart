
import 'package:flutter_app/modules/counter/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(InitialCounterState());

  static CounterCubit get(context)
  {
    return BlocProvider.of(context);
  }

  int count = 0;
  int count2 = 0;

  add()
  {
    count2 = count2 + 60;
    emit(ChangeCounterState());
  }

  sub()
  {
    count --;
    emit(SubCounterState());
  }

  change(bool up)
  {
    if(up)
    {
      count ++;
      emit(AddCounterState(
        s: 'addition',
      ));
    } else
      {
        count --;
        emit(SubCounterState(
          s: 'subtraction',
        ));
      }
  }
}