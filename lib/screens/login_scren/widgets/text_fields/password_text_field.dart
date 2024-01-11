import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/general_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordTextField({required this.passwordController, super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconOpenPassword = CupertinoIcons.lock_circle_fill;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GeneralTextField(
        controller: widget.passwordController,
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
                iconOpenPassword = CupertinoIcons.lock_circle_fill;
              } else {
                iconOpenPassword = CupertinoIcons.lock_open_fill;
              }
            });
          },
          icon: Icon(iconOpenPassword),
        ),
      ),
    );
  }
}
