import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';
import 'package:task_list/domain/models/task_model.dart';

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
    return BlocBuilder<EditTaskBloc, EditTaskState>(
      builder: (context, state) {
        return AlertDialog(
          content: TextField(controller: textEditingController, maxLines: 6),
          actions: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    String commentText = textEditingController.text;
                    context.read<EditTaskBloc>().add(TappedAddComment(
                        task: widget.task, commentText: commentText));
                  });
                  Navigator.pop(context);
                  textEditingController.clear();
                },
                child: const Text('ADD')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('BACK'))
          ],
        );
      },
    );
  }
}
