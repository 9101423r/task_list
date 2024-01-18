import 'package:flutter/material.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/screens/task_screen/widgets/task_stage/task_stage_card.dart';

class StagesOfTaskScreen extends StatelessWidget {
  final Task task;
  const StagesOfTaskScreen({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (task.listOfStages.isEmpty) {
              return const Center(
                child: Text('Just Text'),
              );
            }
            return TaskStageCard(stage: task.listOfStages[index]);
          },
          itemCount: task.listOfStages.length,
        ));
  }
}
