import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String name;
  int age;
  int phone;
  String email;

  UserModel(
      {required this.id,
      required this.name,
      required this.age,
      required this.phone,
        required this.email});




  UserModel.fromJson(Map<String,dynamic>json):this(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    phone: json["phone"],
    email: json["email"],
  );





  Map<String,dynamic>toJson(){
    return{
      "id":  id,
    "name": name,
    "age":age,
    "phone":phone,
    "email":email,
  };}
}





