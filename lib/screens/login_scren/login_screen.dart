import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/authentication_bloc/authntication_bloc.dart';
import 'package:task_list/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:task_list/screens/login_scren/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
              userRepository:
                  context.read<AuthenticationBloc>().userRepository),
          child: const LoginForm(),
        ), // TODO
      )),
    );
  }
}
