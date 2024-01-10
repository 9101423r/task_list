import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_list/domain/auth/firebase_auth.dart';
import 'package:task_list/domain/models/user_model.dart';

class AuthenticationRemote {
  
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  
  Future<void> register(
      String email, String password,String companyName,String fullName,String phoneNumber) async {
    
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        FirebaseUserAuth().createUser(MyUser(email: email, companyName: companyName, phoneNumber: phoneNumber, fullName: fullName));
      });
    
  }
}