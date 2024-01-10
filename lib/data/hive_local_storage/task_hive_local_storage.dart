import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/models/hive_models/task_model.dart';


class TaskHiveLocalStorage {
  String boxName = 'taskBox';
  late final box = Hive.box<Task>(boxName);

  Future<void> addTask(Task task) async {
    await box.put(task.id, task);
  }

  Future<void> addTaskWithUUID(Task task) async{
    await box.put(task.temporaryUUID, task);
  }

  void saveCommentId(Task task, String id) async {
    if(task.temporaryUUID == 'null'){
      box.get(task.id)!.comments.add(id);
    }else{
        box.get(task.temporaryUUID)!.comments.add(id);
    }
 
  }

  void changeStatus(Task task, String status) {
    Task newTask = task;
    newTask.status = int.parse(status);
    box.put(task.temporaryUUID, newTask);
  }
  void clearBox() async{
    await box.clear();
    }
}
