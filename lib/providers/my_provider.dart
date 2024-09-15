import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/models/user_model.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;
  ThemeMode Mytheme = ThemeMode.light;

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isDark = prefs.getBool("isdark");
  if(isDark != null){
    if(isDark == true){Mytheme = ThemeMode.dark;}
    else{ Mytheme = ThemeMode.light; }
    notifyListeners();
  }
  }

  changeTheme(ThemeMode themMode) async {
    Mytheme = themMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isdark', Mytheme == ThemeMode.dark);
    notifyListeners();
  }

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userModel = await FirebaseFunctions.readUserData();
    notifyListeners();
  }
}
