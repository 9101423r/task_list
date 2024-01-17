import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_list/data/open_hive_box.dart';
import 'package:task_list/simple_bloc_observer.dart';

import 'firebase_options.dart';


void main() async {
  print('Its first print');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyGlobalObserver();
  String path  = await initHivePath();

  print('is it printed initPath : $path');
  await registerAdapter();
  print('is it printed registerAdapter');

  await openBox();
  print('is it printed openBox');


  runApp(const MyApp());
}
