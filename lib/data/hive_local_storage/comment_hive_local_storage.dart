import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task_model.dart';


class CommentHiveLocalStorage {
  String boxName = 'commentBox';
  late final box = Hive.box<Comment>(boxName);

  void addComment(Task task, String string) async {
    String id = DateTime.now().toString();
    TaskHiveLocalStorage().saveCommentId(task, id);
    await box.put(id, Comment(id: id, descriptions: string));
  }

  Box<Comment> refreshBox() {
    return box;
  }
}
