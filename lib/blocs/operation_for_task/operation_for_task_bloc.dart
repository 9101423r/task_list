import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_list/data/api/api_from_1c.dart';

import 'package:task_list/domain/repository/local_task_repository.dart';
import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'dart:developer' as dev;

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
      Task newTask = Task(
          id: 0,
          title: event.title,
          descriptions: event.descriptipions,
          status: 1,
          hours: 0,
          temporaryUUID: 'null',
          comments: [],
          refKey: event.refKey,
          typeTask: event.typeOfTask);
      late String companyRefKeyID;

      var collection = FirebaseFirestore.instance.collection('user');
      late var docSnapshot;
      try {
        docSnapshot =
            await collection.doc(FirebaseAuth.instance.currentUser!.email).get();

        Map<String, dynamic> data = docSnapshot.data()!;

        companyRefKeyID = data["ref_key"];
      } on FirebaseException catch (e) {
        dev.log(e.toString());
        companyRefKeyID = '968b4653-12fe-11ed-b540-1078d2580ce6'; // TODO
      } catch (e) {
        print(e);
        companyRefKeyID = '968b4653-12fe-11ed-b540-1078d2580ce6'; // TODO
      }

      Task getTask =
          await ApiFromServer().postTaskForServer(newTask, companyRefKeyID);
      TaskRepository().addTask(getTask);
    }
  }
}
