part of 'operation_for_task_bloc.dart';

sealed class OperationForTaskState extends Equatable {
  const OperationForTaskState();

  @override
  List<Object> get props => [];
}

final class AddingTaskInitial extends OperationForTaskState {}


class TaskLoaded extends OperationForTaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});
  @override
  List<Object> get props => [tasks];
}



class OpenTask extends OperationForTaskState {}

