import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    var collection = getTasksCollection();
    return collection.where("userId",isEqualTo:FirebaseAuth.instance.currentUser!.uid )
        .where("date", isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void>  DeleteTask(String id){
    return getTasksCollection().doc(id).delete();
  }

  static Future<void> Update (TaskModel taskModel){
    return getTasksCollection().doc(taskModel.id).update(taskModel.toJson());
  }

  static Login(String emailAddress ,String password,{required Function onSuccess,required Function onError}
      ) async {
    try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password);
    if(credential.user?.emailVerified == true){
onSuccess();
    }
    ;}
    on FirebaseAuthException catch (e) {
onError(e.message);
  }}

  static CreateAccount(String emailAddress ,String password,{required Function onSuccess,required Function onError,required String username ,required int phone ,required int age }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      credential.user?.sendEmailVerification();
      UserModel userModel = UserModel(id: credential.user!.uid, name: username, age: age, phone: phone,email: emailAddress);
      addUser(userModel);
onSuccess();
    } on FirebaseAuthException catch (e) {
onError(e.message);
    } catch (e) {
      print(e);
      onError(e.toString());
    }
  }


  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (task, _) {
        return task.toJson();
      },
    );
  }



  static addUser (UserModel userModel){
    var collection = getUsersCollection() ;
    var docRef = collection.doc(userModel.id);
    docRef.set(userModel);
  }
}
