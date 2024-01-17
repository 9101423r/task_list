import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:task_list/blocs/operation_for_task/operation_for_task_bloc.dart';
import 'package:task_list/data/hive_local_storage/comment_hive_local_storage.dart';

import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:task_list/screens/task_screen/widgets/comments_card.dart';

class CommentsListView extends StatefulWidget {
  final Task task;

  const CommentsListView({required this.task, super.key});

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  late final Box<Comment> box;
  @override
  void initState() {
    super.initState();
    box = CommentHiveLocalStorage().refreshBox();
    box.watch().listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerValue = BlocProvider.of<OperationForTaskBloc>(context);
    return BlocBuilder<OperationForTaskBloc, OperationForTaskState>(
      builder: (context, state) {
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: box.values
              .where((element) => widget.task.comments.contains(element))
              .map((comment) => CommentsCard(comment: comment))
              .toList(),
        );
      },
    );
  }
}
