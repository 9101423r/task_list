part of 'operation_for_task_bloc.dart';

sealed class OperationForTaskEvent extends Equatable {
  const OperationForTaskEvent();

  @override
  List<Object> get props => [];
}

class OperationForTaskPressedOK extends OperationForTaskEvent {
  final String title;
  final String descriptipions;

  const OperationForTaskPressedOK(this.title, this.descriptipions);
}

class FetchTasks extends OperationForTaskEvent {}

class LoadTaskEvent extends OperationForTaskEvent {}

class DeleteTask extends OperationForTaskEvent {
  final int taskId;

  const DeleteTask(this.taskId);
}

class TaskTapped extends OperationForTaskEvent {
  final BuildContext context;
  final Task task;
  const TaskTapped({required this.context, required this.task});
}

class ClearBoxTapped extends OperationForTaskEvent{
  
}

class PageRefreshed extends OperationForTaskEvent{
  
}
