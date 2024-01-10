import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:task_list/screens/sign_screen/widgets/sign_form.dart';

class SignHome extends StatelessWidget {
  const SignHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => SignInBloc(),
        child: const SignForm(),
      ),
    );
  }
}
