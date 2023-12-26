import 'package:firebase_auth/firebase_auth.dart';

import 'models/models.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser user);

  Future<void> signIn(String email, String password);
}

class FakeUser {
  String email;
  String companyName;
  String password;
  FakeUser(
      {required this.email, required this.companyName, required this.password});
}
