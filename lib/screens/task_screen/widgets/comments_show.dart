import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:task_list/data/hive_local_storage/comment_hive_local_storage.dart';
import 'package:task_list/domain/api/local_task_comment_repositoryt.dart';

import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task_model.dart';

import 'package:task_list/screens/task_screen/widgets/comments_card.dart';

class CommentsListView extends StatefulWidget {
  final LocalCommentRepository commentRepository;
  final Task task;
  final Box<Comment> boxComments;
  const CommentsListView(
      {required this.commentRepository,
      required this.task,
      required this.boxComments,
      super.key});

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
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: box.values
          .where((element) => widget.task.comments.contains(element.id))
          .map((comment) => CommentsCard(comment: comment))
          .toList(),
    );
  }
}
