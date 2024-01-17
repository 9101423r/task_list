part of 'edit_task_bloc.dart';

enum CommentStats { initial, loading, success, failure }

final class TaskDetailsState extends Equatable {
  const TaskDetailsState({
    this.status = CommentStats.initial,
    this.commentList = const [],
  });

  final CommentStats status;
  final List<Comment> commentList;

  TaskDetailsState copyWith({
    CommentStats Function()? status,
    List<Comment> Function()? commentList,
  }) {
    return TaskDetailsState(
      status: status != null ? status() : this.status,
      commentList: commentList != null ? commentList() : this.commentList,
    );
  }

  @override
  List<Object> get props => [status, commentList];
}
