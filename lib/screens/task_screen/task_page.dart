import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/api/local_task_comment_repositoryt.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task_model.dart';

import 'package:task_list/screens/task_screen/widgets/alert_dialog.dart';
import 'package:task_list/screens/task_screen/widgets/comments_show.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_list/screens/task_screen/widgets/just_text.dart';
import 'package:task_list/screens/task_screen/widgets/status_choise.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  const TaskPage({required this.task, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final LocalCommentRepository commentRepository;
  late final box = Hive.box<Comment>('commentBox');

  @override
  void initState() {
    super.initState();
    commentRepository = LocalCommentRepository(task: widget.task);
    box.watch().listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

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
          stringType: 'Descriptions', stringSpec: widget.task.descriptions),
      BlocProvider(
        create: (context) => EditTaskBloc(),
        child: StatusChoise(task: widget.task),
      ),
      JustText(stringType: 'Hour', stringSpec: widget.task.hours.toString()),
      commentsRow(context),
      const Divider(),
      CommentsListView(
          commentRepository: commentRepository,
          task: widget.task,
          boxComments: box),
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
