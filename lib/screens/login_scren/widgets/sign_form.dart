import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/sign_in_bloc/sign_in_bloc.dart';

import 'package:task_list/screens/login_scren/widgets/my_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SignForm extends StatefulWidget {

  const SignForm({super.key});

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  IconData iconOpenPassword = Icons.lock_open;

  final formKey = GlobalKey<FormState>();

  String? _errorMsg;
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc,SignInState>(builder: (context,state){
      return Form(key:formKey,child: Column(
        children: [
          emailTextField(context),
          passwordTextField(context),
          singInButton(context,state),
          
        ],
      ));
    });

  }

  SizedBox singInButton(BuildContext context, SignInState state) {
    return SizedBox(
    width: MediaQuery.of(context).size.width * 0.5,
    child: TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            
              context
                  .read<SignInBloc>()
                  .add(SignInRequired(  email: emailController.text,password:passwordController.text ));
           

          
          }
          print(
              'We must to going try register if server response good go HomePage,else show SnackBar with error ');
        },
        child:  state is SignInProcess ? const CircularProgressIndicator() : Text(
          AppLocalizations.of(context)!.loginButton,
          
        ) ,
  ));
  }
  MyTextField emailTextField(BuildContext context) {
    return MyTextField(
        controller: emailController,
        hintText: 'Email',
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: const Icon(Icons.email),
        errorMsg: _errorMsg,
        validator: (val) {
          if (val!.isEmpty) {
            return AppLocalizations.of(context)!.loginEmpty;
          } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
              .hasMatch(val)) {
            return AppLocalizations.of(context)!.loginEmailValidator;
          }
          return null;
        });
  }
    MyTextField passwordTextField(BuildContext context) {
    return MyTextField(
      controller: passwordController,
      hintText: 'Password',
      obscureText: obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock),
      errorMsg: _errorMsg,
      validator: (val) {
        if (val!.isEmpty) {
          return AppLocalizations.of(context)!.loginEmpty;
        } else if (!RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
            .hasMatch(val)) {
          return AppLocalizations.of(context)!.loginPasswordValidator;
        }
        return null;
      },
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscurePassword = !obscurePassword;
            if (obscurePassword) {
              iconOpenPassword = Icons.lock;
            } else {
              iconOpenPassword = Icons.lock_open;
            }
          });
        },
        icon: Icon(iconOpenPassword),
      ),
    );
  }
}