import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    var providerValue = BlocProvider.of<OperationForTaskBloc>(context);
    return Card(
      color: const Color.fromARGB(255, 232, 244, 250),
      child: GestureDetector(
        onTap: () {
          context
              .read<OperationForTaskBloc>()
              .add(TaskTapped(context: context, task: task));
        },
        child: ListTile(
          title: Text(task.title.toString()),
          subtitle: Text(task.descriptions.toString()),
          trailing: Text(
            task.id.toString(),
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
