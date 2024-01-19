import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_list/constants/load_config.dart';
import 'package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart';

import 'package:task_list/data/open_hive_box.dart';
import 'package:task_list/simple_bloc_observer.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyGlobalObserver();
  String path = await initHivePath();

  await registerAdapter();

  await FirebaseMessaging.instance.requestPermission();
  final fCMToken = await FirebaseMessaging.instance.getToken();
  print('Token : $fCMToken');

  await openBox();
  Map<String, dynamic> json = await LoadConfig().loadJson();
  print(json);

  ImportantFieldsLocalStorage()
      .saveMapValues(json.keys.toList(), json.values.toList());

  print('is it printed openBox');
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  runApp(const MyApp());
}
