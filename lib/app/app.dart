import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_list/app/app_view.dart';
import 'package:task_list/blocs/authentication_bloc/authntication_bloc.dart';
import 'package:task_list/data/open_hive_box.dart';
import 'package:task_list/domain/provider/locale_provider.dart';

import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    openBox();
    return RepositoryProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: ChangeNotifierProvider(
          create: (context) => LocaleProvider(), child: const MyAppView()),
    );
  }
}
