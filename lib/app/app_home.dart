import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/blocs/sign_or_login/sign_or_login_bloc.dart';
import 'package:task_list/constants/load_config.dart';
import 'package:task_list/domain/repository/local_task_repository.dart';

import 'package:task_list/screens/home_screen/home_screen.dart';
import 'package:task_list/screens/login_scren/login_screen.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  TaskRepository taskRepository = TaskRepository();
  PageController pageController = PageController();


 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) =>
                  OperationForTaskBloc(taskRepository: taskRepository)
                    ..add(const TaskListSubscriptionRequested()),
              child: const HomeScreen(),
            );
          } else {
            return BlocProvider(
              create: (context) => SignOrLoginBloc(),
              child: const LoginScreen(),
            );
          }
        });
  }
}
