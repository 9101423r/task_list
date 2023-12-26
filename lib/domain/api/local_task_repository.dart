import 'dart:async';

import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';

import '../models/task_model.dart';

class TaskRepository {
  final _taskBox = TaskHiveLocalStorage().box;

  late StreamController<List<Task>> _tasksController;

  Stream<List<Task>> get tasksStream => _tasksController.stream;

  TaskRepository() {
    _tasksController = StreamController<List<Task>>.broadcast();
    _loadTasks();
  }

  void _loadTasks() {
    _tasksController.add(_taskBox.values.toList());

    _taskBox.watch().listen((event) {
      _tasksController.add(_taskBox.values.toList());
    });
  }

  void dispose() {
    _tasksController.close();
  }
}
