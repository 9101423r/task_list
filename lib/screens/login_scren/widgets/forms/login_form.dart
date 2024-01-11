import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:task_list/constants/app_text_styles.dart';
import 'package:task_list/constants/validator.dart';
import 'package:task_list/domain/api/list_compain.dart';
import 'package:task_list/domain/models/user_model.dart';
import 'package:task_list/screens/login_scren/widgets/company_name_drop_down.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/email_text_field.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/general_text_field.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/password_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  IconData iconOpenPassword = Icons.lock_open;
  bool obscurePassword = true;

  String? _errorMsg;

  String companyName = 'NO company';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              fullNameTextField(context),
              futureCompanyListName(),
              phoneNumberTextField(context),
              EmailTextField(emailController: emailController),
              PasswordTextField(passwordController: passwordController),
              loginButton(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget futureCompanyListName() {
    return Card(
        child: Row(
      children: [
        const Text('Выберите название компании: '),
        Expanded(
          child: FutureBuilder(
              future: ApiFromServer().getListCompany(),
              builder: ((context, snapshot) {
                print('Snapshot.data : ${snapshot.data}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  companyName = snapshot.data!.first;
                  return DropdownButton(
                      itemHeight: 70,
                      isExpanded: true,
                      value: companyName,
                      items: snapshot.data!.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {});
                } else {
                  return const Text('Please refresh page');
                }
              })),
        )
      ],
    ));
  }

  SizedBox loginButton(BuildContext context, SignUpState state) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              MyUser myUser = MyUser.empty;
              myUser = myUser.copyWith(
                  userId: DateTime.now().toString(), // TODO возможно ошибка при одновремнной регистрации
                  email: emailController.text,
                  companyName: companyName,
                  fullName: fullNameController.text,
                  phoneNumber: clearPhoneNumber(phoneNumberController.text));
              context
                  .read<SignUpBloc>()
                  .add(SignUpRequired(myUser, passwordController.text));
            }
            print(
                'We must to going try register if server response good go HomePage,else show SnackBar with error ');
          },
          child: state is SignUpProcess
              ? const CircularProgressIndicator()
              : Text(
                  AppLocalizations.of(context)!.loginButton,
                  style: AppTextStyles.loginButtonText,
                ),
        ));
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Widget phoneNumberTextField(BuildContext context) {
    return Card(
      child: TextFormField(
          controller: phoneNumberController,
          inputFormatters: [maskFormatter],
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.secondary),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: '+7 (###) ###-##-##',
            hintStyle: TextStyle(color: Colors.grey[500]),
            errorText: _errorMsg,
          ),
          obscureText: false,
          keyboardType: TextInputType.phone,
          validator: (val) {
            if (val!.isEmpty) {
              return AppLocalizations.of(context)!.loginEmpty;
            }
            return null;
          }),
    );
  }

  GeneralTextField fullNameTextField(BuildContext context) {
    return GeneralTextField(
        controller: fullNameController,
        hintText: AppLocalizations.of(context)!.loginCompanyName,
        obscureText: false,
        keyboardType: TextInputType.name,
        prefixIcon: const Icon(Icons.person),
        errorMsg: _errorMsg,
        validator: (val) {
          if (val!.isEmpty) {
            return AppLocalizations.of(context)!.loginEmpty;
          }
          return null;
        });
  }
}
