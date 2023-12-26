import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/comments_model.dart';
import 'package:task_list/domain/models/task_model.dart';
import 'package:task_list/screens/task_screen/widgets/comments_card.dart';

class CommentsListView extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Task task;
  final Box<Comment> boxComments;
  const CommentsListView(
      {required this.task, required this.boxComments, super.key});

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  @override
  void initState() {
    super.initState();
    widget.boxComments.watch().listen((event) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: widget.boxComments.values
          .where((element) => widget.task.comments.contains(element.id))
          .map((comment) => CommentsCard(comment: comment))
          .toList(),
    );
  }
}
