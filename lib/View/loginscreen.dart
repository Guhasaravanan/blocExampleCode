import 'package:blocexample/bloc/login_bloc.dart';
import 'package:blocexample/bloc/login_event.dart';
import 'package:blocexample/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login with BLoC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is LoginSuccess) {
              return Center(
                  child: Text("🎉 Login Successful!",
                      style: TextStyle(fontSize: 24)));
            }

            if (state is LoginFailure) {
              return Column(
                children: [
                  _loginForm(loginBloc),
                  SizedBox(height: 16),
                  Text(state.error, style: TextStyle(color: Colors.red)),
                ],
              );
            }

            return _loginForm(loginBloc);
          },
        ),
      ),
    );
  }

  Widget _loginForm(LoginBloc loginBloc) {
    return Column(
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final username = usernameController.text.trim();
            final password = passwordController.text.trim();
            loginBloc.add(LoginButtonPressed(username, password));
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
