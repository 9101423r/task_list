import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as dev;

import 'package:task_list/domain/models/user_model.dart';

class Authentication{
  
  Future<bool> login(String email, String password) async {
     try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(), password: password.trim());
      return true; 
        }
  on FirebaseAuthException catch(exceptions){
    dev.log(exceptions.toString());
    print(exceptions.toString());
     return false;
  }
  }

  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(userId: user.user!.uid);
     
      return myUser;
    } catch (e) {
      dev.log(e.toString());
      rethrow;
    }
  }

  
  // Future<MyUser> register(
  //    MyUser myUser,String password) async {
  //       try{
  //         UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: myUser.email, password: password);
  //         myUser = myUser.copyWith(user); 
  //         }
  //       catch(e){}
    
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: email.trim(), password: password.trim())
  //         .then((value) {
  //       FirebaseUserAuth().createUser(MyUser(email: email, companyName: companyName, phoneNumber: phoneNumber, fullName: fullName));
  //     });
    
  // }
}