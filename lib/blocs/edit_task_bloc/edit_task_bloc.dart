import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_list/constants/validator.dart';
import 'package:task_list/data/hive_local_storage/comment_hive_local_storage.dart';

import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'package:task_list/domain/repository/local_task_comment_repositoryt.dart';


part 'edit_task_event.dart';
part 'edit_task_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  TaskDetailsBloc({required this.task})
      : super(const TaskDetailsState(status: CommentStats.initial)) {
final LocalCommentRepository localCommentRepository = LocalCommentRepository(task: task);
    on<TappedAddComment>((event, emit) async {
      String author = await FirebaseUserAuth().getUserName();
      Comment newComment = Comment(
          author: author,
          timeLikeID: Validator().customDateFormatter(DateTime.now()),
          descriptions: event.commentText);
      CommentHiveLocalStorage().addComment(event.task, newComment);
    });

    on<OnSubscriptionRequested>((event, emit) => _onSubscriptionRequested(event, emit,localCommentRepository));
  }

  Task task;
 

   Future<void> _onSubscriptionRequested(
    OnSubscriptionRequested event,
    Emitter<TaskDetailsState> emit,
    LocalCommentRepository localCommentRepository
  ) async {
    
      emit(state.copyWith(
          status: () => CommentStats.loading,
          commentList: () => localCommentRepository.getListComments()));

      if(localCommentRepository.getListComments().isEmpty){
        emit(const TaskDetailsState(status: CommentStats.success,commentList: []));
      }
      else {
        await emit.forEach<List<Comment>>(
          localCommentRepository.commentsStream,
          onData: (comments) =>
              state.copyWith(
                status: () => CommentStats.success,
                commentList: () => comments,
              ),
          onError: (_, __) =>
              state.copyWith(
                status: () => CommentStats.failure,
              ),
        );
      }
    
  }

}
