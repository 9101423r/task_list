part of 'task_page_bloc.dart';

sealed class TaskPageEvent extends Equatable {
  const TaskPageEvent();

  @override
  List<Object> get props => [];
}

class BackButtonAndWeGoSyncWithServer extends TaskPageEvent {
  final Task oldTask;
  final Task newTask;
  const BackButtonAndWeGoSyncWithServer({required this.oldTask,required this.newTask});
}
