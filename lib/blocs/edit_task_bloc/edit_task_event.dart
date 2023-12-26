part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

class TaskTapped extends EditTaskEvent {
  final BuildContext context;
  final Task task;
  const TaskTapped({required this.context, required this.task});
}

// class TaskStatusTapped extends EditTaskEvent {
//   final BuildContext context;
//   final String choise;
//   const TaskStatusTapped({required this.context, required this.choise});
// }

class TappedAddComment extends EditTaskEvent {
  final Task task;
  final String commentText;
  const TappedAddComment({required this.task, required this.commentText});
}
