import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_list/constants/load_config.dart';
import 'package:task_list/data/auth/firebase_notification.dart';
import 'package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart';

import 'package:task_list/data/open_hive_box.dart';
import 'package:task_list/simple_bloc_observer.dart';

import 'firebase_options.dart';
final  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyGlobalObserver();
  await initHivePath();
  await registerAdapter();
  await openBox();

  await FirebaseNotification().initNotification();

  Map<String, dynamic> json = await LoadConfig().loadJson();

  ImportantFieldsLocalStorage()
      .saveJson(json.keys.toList(), json.values.toList());

  runApp(const MyApp());
}
