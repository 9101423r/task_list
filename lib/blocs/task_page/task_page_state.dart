part of 'task_page_bloc.dart';

enum Status { loading, success }

class TaskPageState extends Equatable {
  final Status status;
  final Task task;
  const TaskPageState({required this.status,required this.task});

  @override
  List<Object> get props => [];
}
