abstract class CounterStates{}

class InitialCounterState extends CounterStates {}

class AddCounterState extends CounterStates
{
  final String s;

  AddCounterState({this.s});
}

class SubCounterState extends CounterStates {
  final String s;

  SubCounterState({this.s});
}

class ChangeCounterState extends CounterStates {
}