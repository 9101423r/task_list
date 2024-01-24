part of 'edit_task_bloc.dart';

sealed class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object> get props => [];
}


class TappedAddComment extends TaskDetailsEvent {
  final Task task;
  final String commentText;
  const TappedAddComment({required this.task, required this.commentText});
}

class OnSubscriptionRequested extends TaskDetailsEvent{}

class TaskUpdated extends TaskDetailsEvent{
  final Task task;
  const TaskUpdated({required this.task});
}