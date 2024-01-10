import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_list/data/open_hive_box.dart';
import 'package:task_list/simple_bloc_observer.dart';

import 'firebase_options.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyGlobalObserver();
  await openBox();

  runApp(MyApp(FirebaseUserRepo()));
}
