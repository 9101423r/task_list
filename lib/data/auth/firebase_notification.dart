import "package:firebase_messaging/firebase_messaging.dart";

class FirebaseNotification {
  final _firebaseMesseging = FirebaseMessaging.instance;

  Future<String> initNotification() async {
    await _firebaseMesseging.requestPermission();
    final fCMToken = await _firebaseMesseging.getToken();

    // TODO send to server
    print('Token : ${fCMToken.toString()}');
    String value = fCMToken.toString();
    print('Token value : ${value.toString()}');
    return value;
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print('WE must push the page');

    // TODO open the task where status change
  }

  Future initPushNotification() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  // Future<void> setSettings() async {
  //   NotificationSettings settings = await _firebaseMesseging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  // }
}
