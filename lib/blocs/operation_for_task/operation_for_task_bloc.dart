import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_list/data/api/api_from_1c.dart';

import 'package:task_list/domain/repository/local_task_repository.dart';
import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

part 'operation_for_task_event.dart';
part 'operation_for_task_state.dart';

class OperationForTaskBloc
    extends Bloc<OperationForTaskEvent, OperationForTaskState> {
  OperationForTaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(OperationForTaskState()) {
    on<TaskListSubscriptionRequested>(
        (event, emit) => _onSubscriptionRequested(event, emit));

    on<OperationForTaskPressedOK>((event, emit) async {
      emit(OperationForTaskState(
          status: TaskStatus.loading, taskList: List.of(state.taskList)));
      Task newTask = Task(
          id: 0,
          title: event.title,
          descriptions: event.descriptipions,
          status: 'Открыта',
          hours: 0,
          temporaryUUID: 'null',
          comments: [],
          refKey: event.refKey,
          typeTask: event.typeOfTask);
      String companyRefKeyID = await FirebaseUserAuth().getCompainRefKey();

      print("companyRefKeyID: $companyRefKeyID");

      Task getTask =
          await ApiFromServer().postTaskForServer(newTask, companyRefKeyID);
      TaskRepository().addTask(getTask);
      emit(OperationForTaskState(
          status: TaskStatus.success, taskList: [getTask]));
      print("is is printed?");
    });

    on<TaskTapped>((event, emit) => taskTapped(event, emit));

    on<ClearBoxTapped>((event, emit) => TaskRepository().clearBox());

    on<PageRefreshed>((event, emit) async {
      // TODO
      await pageRefreshed(event, emit);
    });

    on<SignOut>((event, emit) => FirebaseUserAuth().logOut());
  }

  final TaskRepository _taskRepository;

  Future<void> _onSubscriptionRequested(
    TaskListSubscriptionRequested event,
    Emitter<OperationForTaskState> emit,
  ) async {
    emit(state.copyWith(status: () => TaskStatus.loading));

    await emit.forEach<List<Task>>(
      _taskRepository.tasksStream,
      onData: (tasks) => state.copyWith(
        status: () => TaskStatus.success,
        taskList: () => tasks,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TaskStatus.failure,
      ),
    );
  }

  Future<void> pageRefreshed(
      PageRefreshed event, Emitter<OperationForTaskState> emit) async {
    emit(OperationForTaskState(
        status: TaskStatus.loading, taskList: List.of(state.taskList)));
    print('event.listIDTask.toString(): ${event.listTask.toString()}');
    List<Task> getValuesFromServer =
        await ApiFromServer().getTasksFromServer(event.listTask);
    emit(OperationForTaskState(
        status: TaskStatus.success, taskList: getValuesFromServer));
  }

  void taskTapped(TaskTapped event, Emitter<OperationForTaskState> emit) {
    Navigator.pushNamed(event.context, '/task_screen', arguments: event.task);
  }
}
