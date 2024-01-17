import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';

import 'package:task_list/screens/home_screen/widgets/elements/task_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    var providerValue = BlocProvider.of<OperationForTaskBloc>(context);
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        if (state.taskList.isEmpty) {
          if (state.status == TaskStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status != TaskStatus.success) {
            return const SizedBox();
          } else {
            return const Center(child: Text('JUST TEXT'));
          }
        }
        return ListView.builder(
            itemBuilder: (context, index) {
              return  TaskCard(task: state.taskList[index]);

            },
            itemCount: state.taskList.length);
      },
    );
  }
}
