import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/domain/repository/local_task_repository.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:task_list/screens/home_screen/widgets/elements/task_card.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late Stream<List<Task>> taskStreamController;
  @override
  void initState() {
    super.initState();
    taskStreamController = TaskRepository().tasksStream;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OperationForTaskBloc>().add(PageRefreshed());
      },
      child: StreamBuilder<List<Task>>(
          stream: taskStreamController,
          initialData: TaskRepository().listTask,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskCard(task: snapshot.data!.toList()[index]);
                  },
                  itemCount: snapshot.data!.toList().length);
            } else {
              return const Center(child: Text('JUST TEXT'));
            }
          }),
    );
  }
}
