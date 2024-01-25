import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:task_list/domain/models/user_model.dart';
import 'dart:developer' as dev;

class FirebaseUserAuth {
  final usersCollection = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(MyUser myUser) async {
    try {
      await usersCollection.doc(myUser.email).set(myUser.toDocument());
      return true;
    } on FirebaseAuthException catch (authException) {
      dev.log(authException.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    String email = FirebaseAuth.instance.currentUser!.email!;

    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await usersCollection.doc(email).get();

      return docSnapshot.data()!;
    } on FirebaseException catch (e) {
      dev.log(e.toString());
      print('FirebaseErrors on get ref_key:$e');
      return {'FirebaseErrors': e};
    } catch (e) {
      print('Errors on get ref_key: $e');
      return {'DartError': e};
    }
  }

  Future<void> logOut() async {
    _auth.signOut();
  }
}
