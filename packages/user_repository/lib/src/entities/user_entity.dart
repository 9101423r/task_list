import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String userId;
  final String email;
  final String phoneNumber;
  final String companyName;

  const MyUserEntity(
      {required this.userId,
      required this.email,
      required this.phoneNumber,
      required this.companyName});

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'full_name': phoneNumber,
      'companyName': companyName,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
        userId: doc['userId'],
        email: doc['email'],
        phoneNumber: doc['fullName'],
        companyName: doc['companyName']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, email, phoneNumber, companyName];
}
