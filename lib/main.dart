import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_list/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_list/domain/hive_adapters/comments_adapter.dart';
import 'package:task_list/domain/hive_adapters/task_adapter.dart';
import 'package:task_list/domain/models/comments_model.dart';
import 'package:task_list/domain/models/task_model.dart';
import 'package:task_list/simple_bloc_observer.dart';

import 'firebase_options.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyGlobalObserver();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox<Comment>('commentBox');

  runApp(MyApp(FirebaseUserRepo()));
}
