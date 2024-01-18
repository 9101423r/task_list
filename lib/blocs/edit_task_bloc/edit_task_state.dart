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
    CommentStats? status,
    List<Comment>? commentList,
  }) {
    return TaskDetailsState(
      status: status ?? this.status,
      commentList: commentList ?? this.commentList,
    );
  }

  @override
  List<Object> get props => [status, commentList];
}
