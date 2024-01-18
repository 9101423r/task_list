import 'package:flutter/material.dart';
import 'package:task_list/domain/models/hive_models/list_of_stages.dart';

class TaskStageCard extends StatelessWidget {
  final ListOfStages stage;

  const TaskStageCard({required this.stage, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(stage.descriptions),
          trailing: Checkbox(
            onChanged: (newValue) {
              stage.isDone = !stage.isDone;
            },
            value: stage.isDone,
          )),
    );
  }
}
