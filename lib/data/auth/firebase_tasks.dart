import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_list/domain/models/hive_models/task.dart';
import 'dart:developer' as dev;

class FirebaseTasks {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> addTaskWithId(Task task, String getCompanyName,
      String getCompanyRefKEy, String intID) async {
    try {
      await _fireStore
          .collection('company')
          .doc(getCompanyName)
          .collection('tasks')
          .doc(intID)
          .set(task.toMap(getCompanyRefKEy).cast());
      return true;
    } on FirebaseException catch (firebaseExcaption) {
      dev.log(firebaseExcaption.toString());
      return false;
      // TODO
    } catch (error) {
      dev.log(error.toString());
      return false;
    }
  }
}
