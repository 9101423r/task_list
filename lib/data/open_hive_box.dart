import 'dart:io';
import 'dart:developer' as dev;
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_list/domain/models/hive_models/comments_model.dart';
import 'package:task_list/domain/models/hive_models/task.dart';

Future<void> openBox() async {
  if (Platform.isAndroid) {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);
  }

  await openBox1();
  await openBox2();
}

openBox1() async {
  try {
    Hive.registerAdapter(TaskAdapter());

    await Hive.openBox<Task>('taskBox');
  } on Exception catch (error) {
    dev.log('Ошибка при открытии Box: $error');
  }
}

openBox2() async {
  try {
    Hive.registerAdapter(CommentAdapter());
    await Hive.openBox<Comment>('commentBox');
  } on Exception catch (error) {
    dev.log('Ошибка при открытии Box: $error');
  }
}
