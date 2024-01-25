part of 'operation_for_task_bloc.dart';

enum TaskStatus { initial, loading, success, failure} // TODO delete pageSettings1 and pageSettings2

final class OperationForTaskState extends Equatable {
  const OperationForTaskState({
    this.status = TaskStatus.initial,
    this.taskList = const [],
  });

  final TaskStatus status;
  final List<Task> taskList;

  OperationForTaskState copyWith({
    TaskStatus? status,
    List<Task>?  taskList,
  }) {
    return OperationForTaskState(
      status: status ?? this.status,
      taskList: taskList ?? this.taskList,
    );
  }

  @override
  List<Object> get props => [status, taskList];
}
