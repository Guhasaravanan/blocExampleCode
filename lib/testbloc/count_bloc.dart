import 'package:blocexample/testbloc/count_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountBlock extends Bloc<CountEvent, int> {
  CountBlock() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}
