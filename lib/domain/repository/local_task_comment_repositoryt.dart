import 'dart:async';

import 'package:task_list/data/hive_local_storage/comment_hive_local_storage.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

class LocalCommentRepository {
  final Task task;
  final box = CommentHiveLocalStorage().box;

  LocalCommentRepository({required this.task}) {
    _listComment = returnListComment(task);
  }

  late List<Comment> _listComment;
  List<Comment> get listComment => _listComment;

  List<Comment> returnListComment(Task openTask) {
    List<Comment> taskComments = openTask.comments;

    List<String> commentKeys = [];

    for (var comment in taskComments) {
      commentKeys.add(comment.timeLikeID);
    }

    List<Comment> getComments = box.values
        .toList()
        .where((comment) => commentKeys.contains(comment.timeLikeID))
        .toList();

    return getComments;
  }

  Future<void> saveComment(Comment comment) async {
    CommentHiveLocalStorage().addComment(task, comment);
  }
}
