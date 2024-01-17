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

  Future<String> getCompainRefKey() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
   

    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await usersCollection.doc(email).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;

        String companyRefKeyID = data["ref_key"];
        return companyRefKeyID;
      } else {
        print(
            "Документ не существует для пользователя с UID: ${FirebaseAuth.instance.currentUser!.uid}");
        return 'docSnapshot пустой';
      }
    } on FirebaseException catch (e) {
      dev.log(e.toString());
      print('FirebaseErrors on get ref_key:$e');
      return e.toString();
    } catch (e) {
      print('Errors on get ref_key: $e');
      return e.toString();

      // companyRefKeyID = '968b4653-12fe-11ed-b540-1078d2580ce6'; // TODO
    }
  }
  Future<String> getUserName() async {
    String email = FirebaseAuth.instance.currentUser!.email!;
   

    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await usersCollection.doc(email).get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;

        String userNameFromFirebase = data["fullName"];
        return userNameFromFirebase;
      } else {
        print(
            "Документ не существует для пользователя с UID: ${FirebaseAuth.instance.currentUser!.uid}");
        return 'docSnapshot пустой';
      }
    } on FirebaseException catch (e) {
      dev.log(e.toString());
      print('FirebaseErrors on get ref_key:$e');
      return e.toString();
    } catch (e) {
      print('Errors on get ref_key: $e');
      return e.toString();

      // companyRefKeyID = '968b4653-12fe-11ed-b540-1078d2580ce6'; // TODO
    }
  }

  Future<void> logOut() async {
    _auth.signOut();
  }
}
