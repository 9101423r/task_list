import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:task_list/constants/app_text_styles.dart';
import 'package:task_list/constants/validator.dart';
import 'package:task_list/domain/api/list_compain.dart';
import 'package:task_list/screens/login_scren/widgets/company_name_drop_down.dart';
import 'package:task_list/screens/login_scren/widgets/my_text_field.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeadPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  IconData iconOpenPassword = Icons.lock_open;
  bool obscurePassword = true;
  
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            companyNameTextField(context),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text('Выберите название компании: '),
                FutureListCompanyName(),
              ],
            ),
            const SizedBox(height: 20),
            phoneNumberTextField(context),
            const SizedBox(height: 20),
            emailTextField(context),
            const SizedBox(height: 20),
            passwordTextField(context),
            loginButton(context, state)
              
          ],
        ),
      );
    
      },
      );
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
                companyName: companyNameController.text,
                email: emailController.text,
                phoneNumber: clearPhoneNumber(phoneNumberController.text));
            setState(() {
              context
                  .read<SignUpBloc>()
                  .add(SignUpRequired(myUser, passwordController.text));
            });
          }
          print(
              'We must to going try register if server response good go HomePage,else show SnackBar with error ');
        },
        child:  state is SignUpProcess ? const CircularProgressIndicator() : Text(
          AppLocalizations.of(context)!.loginButton,
          style: AppTextStyles.loginButtonText,
        ) ,
  ));
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
  var maskFormatter = MaskTextInputFormatter(
  mask: '+7 (###) ###-##-##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);

  TextFormField phoneNumberTextField(BuildContext context) {
    return TextFormField(
        controller: phoneNumberController,
        inputFormatters: [ maskFormatter],
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
        });
  }

  MyTextField companyNameTextField(BuildContext context) {
    return MyTextField(
        controller: companyNameController,
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

class FutureListCompanyName extends StatelessWidget {
  const FutureListCompanyName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(future: ApiFromServer().getListCompany(), builder:((context, snapshot) {
        print('Snapshot.data : ${snapshot.data}');
        
       if(snapshot.connectionState == ConnectionState.waiting)
       {
        return const  CircularProgressIndicator();
       }
       
        if(snapshot.hasData){
          String selectedItem = snapshot.data!.first;
          return     DropdownButton(
            itemHeight: 70,
            isExpanded :true,
           
            value: selectedItem,
            items:snapshot.data!.map((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value));
          }).toList(),
          
           
           onChanged: (value){
      
      
           });
        }
        else{
          return const Text('Please refresh page');
        }
      })),
    );
  }
}
