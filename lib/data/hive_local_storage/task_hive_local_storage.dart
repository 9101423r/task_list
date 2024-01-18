import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:uuid/uuid.dart';

class TaskHiveLocalStorage {
  late final box = Hive.box<Task>('taskBox');

  Future<void> addTask(Task task) async {
    await box.put(task.id, task);
  }

  Future<void> deleteTaskWithTemporaryUUID(Task task) async {
    await box.delete(task.temporaryUUID);
  }

  Future<void> addTaskWithUUID(Task task) async {
    String temporaryUUID = const Uuid().v4();
    task.temporaryUUID = temporaryUUID;
    print('UUID.v4: $temporaryUUID');
    print('Local Storage temporaryUUID: ${task.temporaryUUID}');
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
