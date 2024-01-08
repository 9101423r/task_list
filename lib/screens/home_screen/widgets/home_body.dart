import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/api/local_task_repository.dart';
import 'package:task_list/domain/models/task_model.dart';
import 'package:task_list/screens/home_screen/widgets/task_card.dart';


class HomeBody extends StatelessWidget {
  
  const HomeBody({ super.key});

  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
          onRefresh: ()async{
            context.read<OperationForTaskBloc>().add(PageRefreshed());
          },
          child: StreamBuilder<List<Task>>(
              stream: TaskRepository().tasksStream,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                if (snapshot.data == null) {
                  print(snapshot.data);
                  print('its snapshot.dart == null');
                  return const Center(child: Text('No task, No List<Task>'));
                } else {
                  print(snapshot.data);
                  print(snapshot.connectionState);
                  List<Task> listTask = snapshot.data!;
                  return ListView(
                    children:
                        listTask.map((task) => TaskCard(task: task)).toList(),
                  );
                }
              }),
        );
  }
}
