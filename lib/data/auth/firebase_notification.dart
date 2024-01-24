
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/cupertino.dart";
import "package:task_list/main.dart";

import "../hive_local_storage/task_hive_local_storage.dart";

class FirebaseNotification {
  // late BuildContext _context;
  final _firebaseMesseging = FirebaseMessaging.instance;


  Future<String> initNotification() async {
    await _firebaseMesseging.requestPermission();
    final fCMToken = await _firebaseMesseging.getToken();

    String value = fCMToken.toString();


    return value;
  }
  Future<void> initPushNotification() async {
    // _context = context;
    _firebaseMesseging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage );
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print('WE must push the page');

    print(message.data['id']);
    int id = int.parse( message.data['id']);
    print("id.toString(): ${id.toString()}");
    print(message.notification?.title ?? 'message.notification.empty');
    print("myTask : ${TaskHiveLocalStorage().box.get(id)?.id ?? "EMPTY BOX.GET"}");
    navigatorKey.currentState?.pushNamed('/task_screen', arguments: TaskHiveLocalStorage().box.get(id));
    // Navigator.pushNamed( _context,'/task_screen', arguments: TaskHiveLocalStorage().box.get(id));
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Received notification: ${message.notification?.title ?? 'Empty'}');
    //   print('Data payload: ${message.data}');
    //
    //
    //
    //
    //  // Navigator.pushNamed( _context,'/task_screen', arguments: TaskHiveLocalStorage().box.values.where((task) => task.id == message.data['id']).first);
    // });

    // TODO open the task where status change
  }




}
