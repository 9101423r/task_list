import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String phoneNumber;
  final String companyName;

  const MyUser(
      {required this.userId,
      required this.email,
      required this.phoneNumber,
      required this.companyName});

  static const empty =
      MyUser(userId: '', email: '', phoneNumber: '', companyName: '');

  MyUser copyWith(
      {String? userId,
      String? email,
      String? phoneNumber,
      String? companyName}) {
    return MyUser(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        companyName: companyName ?? this.companyName);
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId,
        email: email,
        phoneNumber: phoneNumber,
        companyName: companyName);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      companyName: entity.companyName,
      phoneNumber: entity.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [userId, email, phoneNumber, companyName];
}
