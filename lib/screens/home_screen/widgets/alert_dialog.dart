import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAlertWidget extends StatefulWidget {
  const MyAlertWidget({super.key});

  @override
  State<MyAlertWidget> createState() => _MyAlertWidgetState();
}

class _MyAlertWidgetState extends State<MyAlertWidget> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  void clearController() {
    taskTitleController.clear();
    taskDescriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.75,
          child: AlertDialog(
            content: Column(children: [
              TextField(controller: taskTitleController, autofocus: true),
              TextField(
                controller: taskDescriptionController,
              )
            ]),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String title = taskTitleController.text;
                      String taskDescription = taskDescriptionController.text;
                      context.read<OperationForTaskBloc>().add(
                          OperationForTaskPressedOK(title, taskDescription));
                    });
                    Navigator.pop(context);
                    clearController();
                  },
                  child: Text(AppLocalizations.of(context)!.addButton)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearController();
                  },
                  child: Text(AppLocalizations.of(context)!.cancelButton))
            ],
          ),
        );
      },
    );
  }
}
