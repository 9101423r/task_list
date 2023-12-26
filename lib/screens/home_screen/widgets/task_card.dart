import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          context
              .read<OperationForTaskBloc>()
              .add(TaskTapped(context: context, task: task));
        },
        child: ListTile(
          title: Text(task.title.toString()),
          subtitle: Row(children: [
            Flexible(child: Text(task.descriptions.toString())),
            Text(
              '- Status :${task.hours.toString()}',
              style: const TextStyle(color: Colors.green),
            )
          ]),
          trailing: Text(task.status.toString()),
        ),
      ),
    );
  }
}
