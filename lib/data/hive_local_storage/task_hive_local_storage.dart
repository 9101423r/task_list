import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/task_model.dart';

class TaskHiveLocalStorage {
  String boxName = 'taskBox';
  late final box = Hive.box<Task>(boxName);

  void addTask(Task task) async {
    await box.put(task.temporaryUUID, task);
  }

  void saveCommentId(Task task, String id) async {
    Task newTask = task;
    newTask.comments.add(id);
    box.put(task.temporaryUUID, newTask);
  }

  getValues() {
    return box.values.toList();
  }
}
