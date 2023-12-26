import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';
import 'package:task_list/domain/models/task_model.dart';
import 'package:task_list/screens/task_screen/task_page.dart';

part 'operation_for_task_event.dart';
part 'operation_for_task_state.dart';

class OperationForTaskBloc
    extends Bloc<OperationForTaskEvent, OperationForTaskState> {
  OperationForTaskBloc() : super(AddingTaskInitial()) {
    on<OperationForTaskPressedOK>((event, emit) {
      try {
        TaskHiveLocalStorage().addTask(Task(
            descriptions: event.descriptipions,
            status: 1,
            hours: 0,
            temporaryUUID: DateTime.now().toString(),
            comments: [],
            id: 1,
            title: event.title));

        emit(AddingTaskSuccess());
      } catch (e) {
        print(e);
      }
    });
    on<LoadTaskEvent>((event, emit) {
      final tasks = TaskHiveLocalStorage().box;
      emit(TaskLoaded(tasks: tasks.values.toList()));
    });
    on<TaskTapped>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                    task: event.task,
                  )));
      emit(OpenTask());
    });
  }
}
