import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';


class CommentHiveLocalStorage {

  final box = Hive.box<Comment>('commentBox');

  Future<void> addComment(Task task, Comment comment) async {
    TaskHiveLocalStorage().saveCommentId(task, comment);
    await box.put(comment.timeLikeID, comment);
  }

  Box<Comment> refreshBox() {
    return box;
  }
}
