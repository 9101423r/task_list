import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';
import 'package:task_list/domain/api/list_compain.dart';
import 'package:task_list/domain/api/local_task_repository.dart';
import 'package:task_list/domain/models/hive_models/task_model.dart';

import 'package:task_list/screens/task_screen/task_page.dart';
import 'package:uuid/uuid.dart';

part 'operation_for_task_event.dart';
part 'operation_for_task_state.dart';

class OperationForTaskBloc
    extends Bloc<OperationForTaskEvent, OperationForTaskState> {
  OperationForTaskBloc() : super(AddingTaskInitial()) {
    on<OperationForTaskPressedOK>((event, emit)async => addingTask(event, emit));
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

    on<ClearBoxTapped>((event, emit){
      TaskRepository().clearBox();
    });


    on<PageRefreshed>((event, emit)  async{
      try{
        if(true){ // if datas come here some logic  TODO

        } 
        // ignore: dead_code
        else{ // else 

        } 
      }
      catch(error){
        print('PageRefreshed error: $error');

      }
    });
  }

  Future<void> addingTask(OperationForTaskPressedOK event, Emitter<OperationForTaskState> emit) async {
    {
          late Task newTask;
          List<String> listStr = [];
         try {
           int id = await ApiFromServer().getId();        
           newTask = Task(id: id, title: event.title, descriptions:event.descriptipions, status:1, hours:0, temporaryUUID:'null', comments: listStr);
           TaskRepository().addTask(newTask);
           print(newTask.temporaryUUID);
           emit(AddingTaskSuccess());
         } on Exception catch (e) {
           print(e);
           print('Надо сообщит пользователю что не пришло ответ сервера и этого не будет в общем хранилище ');
           print('Создаеься экзампляр с уникальным temporaryUUID');
           newTask = Task(id: 0, title:event.title, descriptions:event.descriptipions, status:1, hours:0, temporaryUUID:const Uuid().v4(), comments:listStr);
           TaskRepository().addTask(newTask);
         }
       }
  }


}
