import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:task_list/data/hive_local_storage/importan_fields_hive_ld.dart";
import "package:task_list/main.dart";
import "package:task_list/screens/home_screen/home_screen.dart";

import "../hive_local_storage/task_hive_local_storage.dart";

class FirebaseNotification {
  // late BuildContext _context;
  final _firebaseMesseging = FirebaseMessaging.instance;

  Future<String> initNotification() async {
    await _firebaseMesseging.requestPermission();
    final fCMToken = await _firebaseMesseging.getToken();

    String value = fCMToken.toString();
    initPushNotification();

    return value;
  }

  Future<void> initPushNotification() async {
    // _context = context;
    _firebaseMesseging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  void handleMessage(RemoteMessage? message) async {
    print(
        "mportantFieldsLocalStorage().box.values.toList() handleMessage FirebaseNotification keys: ${ImportantFieldsLocalStorage().box.get(1)!.someImportantMaps.keys}");
    print(
        "mportantFieldsLocalStorage().box.values.toList() handleMessage FirebaseNotification values: ${ImportantFieldsLocalStorage().box.get(1)!.someImportantMaps.values}");

    if (message == null) return;

    int id = int.parse(message.data['id']);

    await Future.delayed(const Duration(
        seconds:
            3)); // TODO НАдо придумать и исправить вообще зависимость от двух блоков

    navigatorKey.currentState?.pushNamed('/task_screen',
        arguments: TaskHiveLocalStorage().box.get(id));
    // Navigator.pushNamed( _context,'/task_screen', arguments: TaskHiveLocalStorage().box.get(id));
    // TODO open the task where status change
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
  }
}
