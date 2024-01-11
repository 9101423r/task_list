import 'package:flutter/material.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/general_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController emailController;

  const EmailTextField({required this.emailController, super.key});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  String? _errorMsg;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GeneralTextField(
          controller: widget.emailController,
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
          }),
    );
  }
}
