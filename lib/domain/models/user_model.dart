import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String companyName;
  final String phoneNumber;
  final String fullName;

  const MyUser({required this.userId,required this.email,required this.companyName,required this.phoneNumber,required this.fullName});
   
   Map<String, Object> toDocument() {
    return {
      'userId':userId,
      'email': email,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'fullName': fullName,
    };
  }
  static const empty =
      MyUser(userId: '', email: '',  companyName: '',phoneNumber: '', fullName: '');


  static MyUser fromDocument(Map<String, dynamic> doc) {
    return MyUser(
      userId: doc['userId'],
        email: doc['email'],
        companyName: doc['companyName'],
        phoneNumber: doc['phoneNumber'],
        fullName: doc['fullName']);
  }

  MyUser copyWith(
      {String? userId,
        String? email,
      String? companyName,
      String? phoneNumber,
      String? fullName}) {
    return MyUser(
      userId: userId ?? this.userId,
        email: email ?? this.email,
        companyName: companyName ?? this.companyName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        fullName: fullName ?? this.fullName);
  }
  
  @override
  List<Object?> get props => [userId, email, companyName,phoneNumber, fullName];
}