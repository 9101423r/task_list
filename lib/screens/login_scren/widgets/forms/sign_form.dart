import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:task_list/constants/app_text_styles.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/email_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/password_text_field.dart';

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

  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (BuildContext context, SignInState state) {
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.firebaseException)));
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
        return Form(
            key: formKey,
            child: Column(
              children: [
                EmailTextField(emailController: emailController),
                PasswordTextField(passwordController: passwordController),
                singInButton(context, state),
              ],
            ));
      }),
    );
  }

  SizedBox singInButton(BuildContext context, SignInState state) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<SignInBloc>().add(SignInRequired(
                  email: emailController.text,
                  password: passwordController.text));
            }
          },
          child: state is SignInProcess
              ? const CircularProgressIndicator()
              : Text(
                  AppLocalizations.of(context)!.loginButton,
                  style: AppTextStyles.loginButtonText,
                ),
        ));
  }
}
