import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:task_list/screens/task_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/task_screen/widgets/comments_show.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/screens/task_screen/widgets/just_text.dart';

import '../../data/hive_local_storage/importan_fields_hive_ld.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  const TaskPage({required this.task, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: const BackButton()),
        body: SingleChildScrollView(
          child: bodyMain(context),
        ));
  }

  Column bodyMain(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      JustText(stringType: 'Name', stringSpec: widget.task.title),
      JustText(
          stringType: 'Type',
          stringSpec: ImportantFieldsLocalStorage()
              .box
              .values
              .first
              .typeTaskAndRefKey
              .entries
              .firstWhere((entry) => entry.key == widget.task.refKey)
              .value
              .toString()),
      JustText(stringType: 'NumberID', stringSpec: widget.task.id.toString()),
      JustText(
          stringType: 'Descriptions', stringSpec: widget.task.descriptions),
      JustText(stringType: 'Status', stringSpec: widget.task.status),
      JustText(stringType: 'Hour', stringSpec: widget.task.hours.toString()),
      commentsRow(context),
      const Divider(),
      CommentsListView(
        task: widget.task,
      ),
    ]);
  }

  Row commentsRow(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: JustText(stringType: 'Comments', stringSpec: '')),
        TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => EditTaskBloc(),
                      child: MyAlertDialogForAddingComment(task: widget.task),
                    );
                  });
            },
            child: Text(AppLocalizations.of(context)!.addComment))
      ],
    );
  }
}
