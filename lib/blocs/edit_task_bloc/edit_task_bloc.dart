import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_list/constants/validator.dart';
import 'package:task_list/data/hive_local_storage/comment_hive_local_storage.dart';
import 'package:task_list/data/hive_local_storage/task_hive_local_storage.dart';
import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

import 'package:task_list/screens/task_screen/task_page.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc() : super(EditTaskInitial()) {
    on<TaskTapped>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                    task: event.task,
                  )));
      emit(OpenTask());
    });

    on<TappedAddComment>((event, emit) async {
      String author = await FirebaseUserAuth().getUserName();
      Comment newComment = Comment(
          author: author,
          timeLikeID: Validator().customDateFormatter(DateTime.now()),
          descriptions: event.commentText);
      CommentHiveLocalStorage().addComment(event.task, newComment);
    });

    on<ChangeStatus>((event, emit) {
      TaskHiveLocalStorage().changeStatus(event.task, event.status);
    });
  }
}
