import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constants/routes.dart';
import 'package:test_project/services/auth/auth_exceptions.dart';
import 'package:test_project/services/auth/bloc/auth_bloc.dart';
import 'package:test_project/services/auth/bloc/auth_event.dart';
import 'package:test_project/services/auth/bloc/auth_state.dart';
import 'package:test_project/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: "Enter Your email here"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Enter Your password",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              context.read<AuthBloc>().add(
                    AuthEventLogIn(
                      email,
                      password,
                    ),
                  );
            },
            child: const Text('login'),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateLoggedOut) {
                if (state.exception is UserNotFoundAuthException) {
                  showErrorDialog(context, "User Not Found");
                } else if (state.exception is WrongPasswordAuthException) {
                  showErrorDialog(context, "Wrong credentials");
                } else if (state.exception is GenericAuthException) {
                  showErrorDialog(context, "Authentication error");
                }
              }
            },
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Not registered? Register here!'),
            ),
          )
        ],
      ),
    );
  }
}
