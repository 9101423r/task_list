import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_list/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:task_list/blocs/sign_or_login/sign_or_login_bloc.dart';

import 'package:task_list/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:task_list/domain/provider/locale_provider.dart';
import 'package:task_list/screens/login_scren/widgets/forms/login_form.dart';
import 'package:task_list/screens/login_scren/widgets/forms/sign_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool swipe = true;
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
      child: Column(
        children: [
          swipePageText(context),
          changeLocale(context)
        ],
      ),
    );
  }
  Widget changeLocale(BuildContext context){
    return GestureDetector(
            onTap: () {
                 Provider.of<LocaleProvider>(context, listen: false)
                        .changeLocale();
            },
            child: Text(
              AppLocalizations.of(context)!.changeLocale,
              style: const TextStyle(color: Colors.blue),
            ), // TODO style
          );
  }

  Widget swipePageText(BuildContext context){
    return           GestureDetector(
            onTap: () {
              context.read<SignOrLoginBloc>().add(JustSwipe(swipePage: swipe));
              swipe = !swipe;
            },
            child: Text(
              swipe ? 'Do you have account?' : 'Do you havenot account?',
              style: const TextStyle(color: Colors.blue),
            ), // TODO style
          );
  }
}
