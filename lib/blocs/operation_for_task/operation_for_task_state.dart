part of 'operation_for_task_bloc.dart';

enum TaskStatus { initial, loading, success, failure }

final class OperationForTaskState extends Equatable {
  const OperationForTaskState({
    this.status = TaskStatus.initial,
    this.taskList = const [],
  });

  final TaskStatus status;
  final List<Task> taskList;

  OperationForTaskState copyWith({
    TaskStatus Function()? status,
    List<Task> Function()? taskList,
  }) {
    return OperationForTaskState(
      status: status != null ? status() : this.status,
      taskList: taskList != null ? taskList() : this.taskList,
    );
  }

  @override
  List<Object> get props => [status, taskList];
}
