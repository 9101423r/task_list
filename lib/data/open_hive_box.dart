import 'package:hive_flutter/adapters.dart';
import 'package:task_list/domain/hive_adapters/comments_adapter.dart';
import 'package:task_list/domain/hive_adapters/task_adapter.dart';
import 'package:task_list/domain/models/comments_model.dart';
import 'package:task_list/domain/models/task_model.dart';

void openBox() async{
  openBox2();
  openBox1();

openBox2();
  openBox1();

}


openBox1()async{
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');
}

openBox2() async{
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox<Comment>('commentBox');
}