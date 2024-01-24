import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_list/data/api/api_from_1c.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

part 'task_page_event.dart';
part 'task_page_state.dart';

class TaskPageBloc extends Bloc<TaskPageEvent, TaskPageState> {
  final Task task;
  TaskPageBloc({required this.task})
      : super(TaskPageState(status: Status.success, task: task)) {
    on<BackButtonAndWeGoSyncWithServer>((event, emit) async {
      emit(TaskPageState(status: Status.loading, task: task));
      if (event.oldTask != event.newTask) {
        Task newTask = await ApiFromServer().postTaskForServer(event.newTask);
        emit(TaskPageState(status: Status.success, task: newTask));
      }
    });
  }
}
