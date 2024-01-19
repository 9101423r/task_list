import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;

import 'package:task_list/domain/models/user_model.dart';

class Authentication {
  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return 'Success';
    } on FirebaseAuthException catch (exceptions) {
      dev.log(exceptions.toString());

      return exceptions.toString();
    }
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: myUser.email, password: password);

      myUser = myUser.copyWith(userId: user.user!.uid);

      return myUser;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }
}
