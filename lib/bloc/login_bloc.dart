import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay

      if (event.username == 'admin' && event.password == '1234') {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Invalid username or password"));
      }
    });
  }
}
