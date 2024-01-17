import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/drop_down_bloc/drop_down_bloc.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/data/api/api_from_1c.dart';
import 'package:task_list/screens/general_widgets/company_name_drop_down.dart';

class MyAlertWidget extends StatefulWidget {
  const MyAlertWidget({super.key});

  @override
  State<MyAlertWidget> createState() => _MyAlertWidgetState();
}

class _MyAlertWidgetState extends State<MyAlertWidget> {
  TextEditingController taskTitleController = TextEditingController();

  TextEditingController taskDescriptionController = TextEditingController();

  final Future<List<List<String>>> getFutureList =
      ApiFromServer().getTypeTaskFromServer();

  void clearController() {
    taskTitleController.clear();
    taskDescriptionController.clear();
  }



  String refKey = '';

  late String typeOfTask;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      // C FutureBuilder только онлайн будет работать
      builder: (context, state) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(children: [
              TextField(
                  controller: taskTitleController,
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Task title')),
              TextField(
                  controller: taskDescriptionController,
                  maxLines: 2,
                  decoration:
                      const InputDecoration(hintText: 'Task description')),
              BlocProvider(
                create: (context) => DropDownBloc(),
                child: Expanded(
                    child: DropDownWithRefKeyAndChangeValue(
                  onRefKeyGetIt: (String value) {
                    refKey = value;
                  },
                  getFutureList: getFutureList,
                  onDropDownValueChoose: (String newValue) {
                    typeOfTask = newValue;
                  }, typeGetFutureList: 'TypeTaskAndID',
                )),
              )
            ]),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  String title = taskTitleController.text;
                  String taskDescription = taskDescriptionController.text;

                  context.read<OperationForTaskBloc>().add(
                      OperationForTaskPressedOK(
                          title, taskDescription, refKey));
                  print('Выбранный refKey :$refKey');
                  Navigator.pop(
                      context); // RefKey ключевое представление самого типа задачи
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
        );
      },
    );
  }
}
