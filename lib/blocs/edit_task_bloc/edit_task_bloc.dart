import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_list/data/hive_local_storage/comment_hive_local_storage.dart';
import 'package:task_list/domain/models/task_model.dart';
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

    on<TappedAddComment>((event, emit) {
      CommentHiveLocalStorage().addComment(event.task, event.commentText);
    });
  }
}
