import 'package:blocexample/model/todo_model.dart';
import 'package:blocexample/todobloc/todo_event.dart';
import 'package:blocexample/todobloc/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<Todo> _todos = [];

  TodoBloc() : super(TodoInitial()) {
    on<LoadTodo>((event, emit) {
      emit(TodoLoaded(List.from(_todos)));
    });
    on<AddTodo>((event, emit) {
      _todos.add(event.todo);
      emit(TodoLoaded(List.from(_todos)));
    });

    on<UpdateTodo>((event, emit) {
      final index = _todos.indexWhere((todo) => todo.id == event.todo.id);
      if (index != -1) {
        _todos[index] = event.todo;
        emit(TodoLoaded(List.from(_todos)));
      }
    });
    on<DeleteTodo>((event, emit) {
      _todos.removeWhere((todo) => todo.id == event.id);
      emit(TodoLoaded(List.from(_todos)));
    });
  }
}
