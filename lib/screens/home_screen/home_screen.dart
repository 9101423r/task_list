import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';

import 'package:task_list/screens/home_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/home_screen/widgets/elements/pop_up_menu_button.dart';
import 'package:task_list/screens/home_screen/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: const Text('TaskList'),
              actions: const [PopUpMenuButton()]),
          body: const HomeBody(),
          floatingActionButton: floatingActionButton(context),
        );
      },
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return BlocProvider(
                create: (context) => OperationForTaskBloc(),
                child: const MyAlertWidget(),
              );
            });
      },
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
