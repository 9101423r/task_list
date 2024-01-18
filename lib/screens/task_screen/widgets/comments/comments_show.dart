import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_list/blocs/edit_task_bloc/edit_task_bloc.dart';

import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/screens/task_screen/widgets/comments/comments_card.dart';

class CommentsListView extends StatefulWidget {
  final Task task;

  const CommentsListView({required this.task, super.key});

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        if (state.commentList.isEmpty) {
          if (state.status == CommentStats.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status != CommentStats.success) {
            return const SizedBox();
          } else {
            return const Center(child: Text('JUST TEXT'));
          }
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return CommentsCard(comment: state.commentList[index]);
          },
          itemCount: state.commentList.length,
        );
      },
    );
  }
}
