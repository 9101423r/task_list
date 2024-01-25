import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/main.dart';

import 'package:task_list/screens/task_screen/widgets/elements/alert_dialog.dart';
import 'package:task_list/screens/task_screen/widgets/comments/comments_show.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/screens/task_screen/widgets/elements/just_text.dart';
import 'package:task_list/screens/task_screen/widgets/elements/pop_u_menu.dart';

import '../../data/hive_local_storage/importan_fields_hive_ld.dart';
import '../../domain/repository/local_task_comment_repositoryt.dart';

class TaskPage extends StatelessWidget {
  final Task task;
  const TaskPage({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    LocalCommentRepository localCommentRepository =
        LocalCommentRepository(task: task);
    return BlocProvider(
        create: (context) =>
            TaskDetailsBloc(localCommentRepository: localCommentRepository),
        child: TaskPageStateFull(
          task: task,
        ));
  }
}

class TaskPageStateFull extends StatefulWidget {
  final Task task;
  const TaskPageStateFull({required this.task, super.key});

  @override
  State<TaskPageStateFull> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPageStateFull> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              print('We are must to back HomePage from TaskPage');
              Navigator.pop(context, widget.task);
            },
          ),
          actions: [
            TaskPopUpMenuButton(
              task: widget.task,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: bodyMain(context),
        ));
  }

  Column bodyMain(BuildContext context) {
    var providerValue = BlocProvider.of<TaskDetailsBloc>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      JustText(stringType: 'Name', stringSpec: widget.task.title),
      JustText(
          stringType: 'TaskType',
          stringSpec: ImportantFieldsLocalStorage()
                  .returnTypeTaskJson()?[widget.task.refKey] ??
              'Empty'),
      JustText(stringType: 'NumberID', stringSpec: widget.task.id.toString()),
      JustText(
          stringType: 'Descriptions', stringSpec: widget.task.descriptions),
      JustText(stringType: 'Status', stringSpec: widget.task.status),
      JustText(stringType: 'Hour', stringSpec: widget.task.hours.toString()),
      Row(
        children: [
          const Expanded(
              child: JustText(stringType: 'Comments', stringSpec: '')),
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider.value(
                        value: providerValue,
                        child: MyAlertDialogForAddingComment(task: widget.task),
                      );
                    });
              },
              child: Text(AppLocalizations.of(context)!.addComment))
        ],
      ),
      BlocProvider.value(
        value: providerValue..add(OnSubscriptionRequested()),
        child: CommentsListView(
          task: widget.task,
        ),
      ),
    ]);
  }
}
