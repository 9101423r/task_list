import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:task_list/blocs/drop_down_bloc/drop_down_bloc.dart';
import 'package:task_list/blocs/sign_up_bloc/sign_up_bloc.dart';

import 'package:task_list/constants/app_text_styles.dart';
import 'package:task_list/constants/validator.dart';

import 'package:task_list/data/api/api_from_1c.dart';
import 'package:task_list/domain/models/user_model.dart';

import 'package:task_list/screens/general_widgets/company_name_drop_down.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/email_text_field.dart';
import 'package:task_list/screens/login_scren/widgets/text_fields/general_text_field.dart';
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
  // final Future<List<List<String>>> getFutureList =
  //     ApiFromServer().getListCompany();
  String refKey = '';

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
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: Row(
        children: [
          Text('${AppLocalizations.of(context)!.loginCompanyName}:',
              style: AppTextStyles.companyName, maxLines: 2),
          // BlocProvider(
          //   create: (context) => DropDownBloc(),
          //   child: Expanded(
          //       child: DropDownWithRefKeyAndChangeValue(
          //     onRefKeyGetIt: (String value) {
          //       refKey = value;
          //     },
          //     getFutureList: getFutureList,
          //     onDropDownValueChoose: (String newValue) {
          //       companyName = newValue;
          //     },
          //     typeGetFutureList: 'CompanyNamesAndID',
          //   )),
          // )
        ],
      ),
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
                  userId: DateTime.now().toString(),
                  email: emailController.text,
                  companyName: companyName,
                  fullName: fullNameController.text,
                  phoneNumber:
                      Validator().clearPhoneNumber(phoneNumberController.text),
                  refKey: refKey);

              context
                  .read<SignUpBloc>()
                  .add(SignUpRequired(myUser, passwordController.text));
            }
          },
          child: state is SignUpProcess
              ? const CircularProgressIndicator()
              : Text(
                  AppLocalizations.of(context)!.loginButton,
                  style: AppTextStyles.loginButtonText,
                ),
        ));
  }

  Widget phoneNumberTextField(BuildContext context) {
    return Card(
      child: TextFormField(
          controller: phoneNumberController,
          inputFormatters: [Validator().maskFormatter],
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
        hintText: AppLocalizations.of(context)!.fullName,
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
