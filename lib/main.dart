import 'package:blocexample/View/todoScreen.dart';
import 'package:blocexample/todobloc/todo_bloc.dart';
import 'package:blocexample/todobloc/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoScreen(),
      ),
    );
  }
}
