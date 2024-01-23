import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String companyName;
  final String phoneNumber;
  final String fullName;
  final String refKey;
  final String fcmToken;

  const MyUser(
      {required this.userId,
      required this.email,
      required this.companyName,
      required this.phoneNumber,
      required this.fullName,
      required this.refKey,
      required this.fcmToken});

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
      "ref_key": refKey,
      "fcmToken": fcmToken
    };
  }

  static const empty = MyUser(
      userId: '',
      email: '',
      companyName: '',
      phoneNumber: '',
      fullName: '',
      refKey: '',
      fcmToken: '');

  static MyUser fromDocument(Map<String, dynamic> doc) {
    return MyUser(
        userId: doc['userId'],
        email: doc['email'],
        companyName: doc['companyName'],
        phoneNumber: doc['phoneNumber'],
        fullName: doc['fullName'],
        refKey: doc["refKey"],
        fcmToken: doc["fcmToken"]);
  }

  MyUser copyWith(
      {String? userId,
      String? email,
      String? companyName,
      String? phoneNumber,
      String? fullName,
      String? refKey,
      String? fcmToken}) {
    return MyUser(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        companyName: companyName ?? this.companyName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        fullName: fullName ?? this.fullName,
        refKey: refKey ?? this.refKey,
        fcmToken: fcmToken ?? this.fcmToken);
  }

  @override
  List<Object?> get props =>
      [userId, email, companyName, phoneNumber, fullName, refKey, fcmToken];
}
