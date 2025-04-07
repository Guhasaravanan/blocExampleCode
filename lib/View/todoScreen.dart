import 'package:blocexample/model/todo_model.dart';
import 'package:blocexample/todobloc/todo_bloc.dart';
import 'package:blocexample/todobloc/todo_event.dart';
import 'package:blocexample/todobloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('ToDo App with BLoC')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter todo',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                final todo =
                    Todo(id: uuid.v4(), title: _controller.text.trim());
                todoBloc.add(AddTodo(todo));
                _controller.clear();
              }
            },
            child: Text("Add Todo"),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return Center(child: Text("No ToDos Yet"));
                  }

                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            todoBloc.add(DeleteTodo(todo.id));
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
