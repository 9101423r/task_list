import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/task_model.dart';

class TaskHiveLocalStorage {
  String boxName = 'taskBox';
  late final box = Hive.box<Task>(boxName);

  void addTask(Task task) async {
    await box.put(task.temporaryUUID, task);
  }

  void saveCommentId(Task task, String id) async {
    box.get(task.temporaryUUID)!.comments.add(id);
  }

  void changeStatus(Task task, String status) {
    Task newTask = task;
    newTask.status = int.parse(status);
    box.put(task.temporaryUUID, newTask);
  }
}
