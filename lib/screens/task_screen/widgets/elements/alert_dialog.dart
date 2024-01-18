import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyAlertDialogForAddingComment extends StatefulWidget {
  final Task task;
  const MyAlertDialogForAddingComment({required this.task, super.key});

  @override
  State<MyAlertDialogForAddingComment> createState() =>
      _MyAlertDialogForAddingCommentState();
}

class _MyAlertDialogForAddingCommentState
    extends State<MyAlertDialogForAddingComment> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        return AlertDialog(
          content: TextField(controller: textEditingController, maxLines: 6),
          actions: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    String commentText = textEditingController.text;
                    context.read<TaskDetailsBloc>().add(TappedAddComment(
                        task: widget.task, commentText: commentText));
                  });
                  Navigator.pop(context);
                  textEditingController.clear();
                },
                child: Text(AppLocalizations.of(context)!.addButton)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancelButton))
          ],
        );
      },
    );
  }
}
