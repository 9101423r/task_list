import 'package:flutter/material.dart';

import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/screens/task_screen/widgets/task_stage/stages_of_task_screen.dart';

enum PopUpElements { showStages }

class TaskPopUpMenuButton extends StatefulWidget {
  final Task task;

  const TaskPopUpMenuButton({required this.task, super.key});

  @override
  PopUpMenuButtonState createState() => PopUpMenuButtonState();
}

class PopUpMenuButtonState extends State<TaskPopUpMenuButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopUpElements>(
        itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: PopUpElements.showStages,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return StagesOfTaskScreen(task: widget.task);
                  })));
                },
                child: const Text('Push for Stages'),
              ),
            ]);
  }
}
