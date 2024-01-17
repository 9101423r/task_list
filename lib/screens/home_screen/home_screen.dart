import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/repository/local_task_repository.dart';

import 'package:task_list/screens/home_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/home_screen/widgets/elements/pop_up_menu_button.dart';
import 'package:task_list/screens/home_screen/widgets/elements/task_card.dart';
import 'package:task_list/screens/home_screen/widgets/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // TODO delete initState
  @override
  Widget build(BuildContext context) {
    var providerValue = BlocProvider.of<OperationForTaskBloc>(context);
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              leading: const Text('TaskList'),
              actions: const [PopUpMenuButton()]),
          body: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<OperationForTaskBloc>()
                  .add(PageRefreshed(listTask: state.taskList));
            },
            child: BlocProvider.value(value: providerValue,child: const HomeBody())
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: providerValue,
                      child: const MyAlertWidget(),
                    );
                  });
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
