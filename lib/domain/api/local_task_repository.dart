import 'dart:async';

import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';

import '../models/hive_models/task.dart';

class TaskRepository {
  final _taskBox = TaskHiveLocalStorage().box;

  late StreamController<List<Task>> _tasksController;
  late List<Task> _cachedTasks;

  Stream<List<Task>> get tasksStream => _tasksController.stream;

  TaskRepository() {
    _tasksController = StreamController<List<Task>>.broadcast();
    _cachedTasks = _taskBox.values.toList();
    _loadTasks();
  }

  void _loadTasks() {
    _tasksController.add(_cachedTasks);

    _taskBox.watch().listen((event) {
      _cachedTasks = _taskBox.values.toList();
      _tasksController.add(_cachedTasks);
    });
  }

  void addTask(Task task) async{
    print(task.temporaryUUID);
    if(task.temporaryUUID == 'null') {
      await TaskHiveLocalStorage().addTask(task);
    }
    else{
      await TaskHiveLocalStorage().addTaskWithUUID(task);
    }
  }


  void clearBox(){
    TaskHiveLocalStorage().clearBox();
  }

  void dispose() {
    _tasksController.close();
  }
}
