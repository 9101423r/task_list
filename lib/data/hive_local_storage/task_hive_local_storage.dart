import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:uuid/uuid.dart';

class TaskHiveLocalStorage {
  String boxName = 'taskBox';
  late final box = Hive.box<Task>(boxName);

  Future<void> addTask(Task task) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTaskWithTemporaryUUID(Task task) async {
    await box.delete(task.temporaryUUID);
  }

  Future<void> addTaskWithUUID(Task task) async {
    task.temporaryUUID == const Uuid().v4();
    await box.put(task.temporaryUUID, task);
  }

  void saveCommentId(Task task, Comment comment) async {
    if (task.temporaryUUID == 'null') {
      box.get(task.id)!.comments.add(comment);
    } else {
      box.get(task.temporaryUUID)!.comments.add(comment);
    }
  }

  void changeStatus(Task task, String status) {
    Task newTask = task;
    newTask.status = status;
    box.put(task.temporaryUUID, newTask);
  }

  void clearBox() async {
    await box.clear();
  }
}
