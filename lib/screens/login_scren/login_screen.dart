import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:task_list/blocs/sign_or_login/sign_or_login_bloc.dart';

import 'package:task_list/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:task_list/screens/login_scren/widgets/login_form.dart';
import 'package:task_list/screens/login_scren/widgets/sign_form.dart';

class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool swipe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<SignOrLoginBloc, SignOrLoginState>(
          builder: ((context, state) {
            if (state is Login) {
              return Column(children: [
                BlocProvider(
                  create: (context) => SignUpBloc(),
                  child: const LoginForm(),
                ),
                swipeText(context)
              ]);
            } else {
              return Column(
                children: [
                  BlocProvider(
                    create: (context) => SignInBloc(),
                    child: const SignForm(),
                  ),
                  swipeText(context)
                ],
              );
            }
          }),
          
        ), // TODO
      )),
    );
  }

  Align swipeText(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: () {

          context.read<SignOrLoginBloc>().add(JustSwipe(swipePage: swipe));
        
  swipe = !swipe;

        
        },
        child: const Text(
          'Do you have account?',
          style: TextStyle(color: Colors.blue),
        ), // TODO style
      ),
    );
  }
}
