import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_list/constants/validator.dart';

import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/domain/repository/local_task_comment_repositoryt.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  TaskDetailsBloc({required LocalCommentRepository localCommentRepository})
      : super(const TaskDetailsState(status: CommentStats.initial)) {
    on<TappedAddComment>((event, emit) async {
      String author = await FirebaseUserAuth().getUserName();
      Comment newComment = Comment(
          author: author,
          timeLikeID: Validator().customDateFormatter(DateTime.now()),
          descriptions: event.commentText);
      localCommentRepository.saveComment(newComment);
    });

    on<OnSubscriptionRequested>((event, emit) =>
        _onSubscriptionRequested(event, emit, localCommentRepository));
  }

  Future<void> _onSubscriptionRequested(
      OnSubscriptionRequested event,
      Emitter<TaskDetailsState> emit,
      LocalCommentRepository localCommentRepository) async {
    emit(state.copyWith(
        status: CommentStats.loading,
        commentList: localCommentRepository
            .returnListComment(localCommentRepository.task)));

    if (localCommentRepository
        .returnListComment(localCommentRepository.task)
        .isEmpty) {
      emit(const TaskDetailsState(
          status: CommentStats.success, commentList: []));
    } else {
      emit(TaskDetailsState(
          status: CommentStats.success,
          commentList: localCommentRepository
              .returnListComment(localCommentRepository.task)));
    }
  }
}
