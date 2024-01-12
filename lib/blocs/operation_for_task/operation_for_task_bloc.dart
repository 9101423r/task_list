import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_list/data/api/api_from_1c.dart';
import 'package:task_list/domain/api/local_task_repository.dart';
import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:uuid/uuid.dart';

part 'operation_for_task_event.dart';
part 'operation_for_task_state.dart';

class OperationForTaskBloc
    extends Bloc<OperationForTaskEvent, OperationForTaskState> {
  OperationForTaskBloc() : super(AddingTaskInitial()) {
    on<OperationForTaskPressedOK>(
        (event, emit) async => addingTask(event, emit));

    on<TaskTapped>((event, emit) {
      Navigator.pushNamed(event.context, '/task_screen', arguments: event.task);
      emit(OpenTask());
    });

    on<ClearBoxTapped>((event, emit) {
      TaskRepository().clearBox();
    });

    on<PageRefreshed>((event, emit) async {
      try {
        if (true) {
          // if datas come here some logic  TODO
        }
        // ignore: dead_code
        else {
          // else
        }
      } catch (error) {}
    });
    on<SignOut>((event, emit) {
      FirebaseUserAuth().logOut();
    });
  }

  Future<void> addingTask(OperationForTaskPressedOK event,
      Emitter<OperationForTaskState> emit) async {
    {
      late Task newTask;
      List<String> listStr = [];
      try {
        int id = await ApiFromServer().getId();
        newTask = Task(
            id: id,
            title: event.title,
            descriptions: event.descriptipions,
            status: 1,
            hours: 0,
            temporaryUUID: 'null',
            comments: listStr,
            refKey: event.refKey,
            typeTask: event.typeOfTask);
        TaskRepository().addTask(newTask);
        emit(AddingTaskSuccess());
      } on Exception catch (e) {
        // TODO
        newTask = Task(
            id: 0,
            title: event.title,
            descriptions: event.descriptipions,
            status: 1,
            hours: 0,
            temporaryUUID: const Uuid().v4(),
            comments: listStr,
            refKey: event.refKey,
            typeTask: event.typeOfTask);
        TaskRepository().addTask(newTask);
      }
    }
  }
}
