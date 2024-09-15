import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo/edit_tab.dart';
import 'package:todo/home.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/register/login.dart';
import 'package:todo/register/signup.dart';
import 'package:todo/theme.dart';

import 'firebase_options.dart';

void main ()async{

  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  await FirebaseFirestore.instance.enableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider()..getTheme(),

      child:

      MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return MaterialApp(
      initialRoute:provider.firebaseUser!=null?
      HomePage.routeName:
      LoginScreen.routeName,
      themeMode: provider.Mytheme ,
      theme:Mytheme.LightTheme,
      darkTheme:Mytheme.DarkTheme,
      routes: {

        EditTab.routeName :(context) => EditTab(),
        HomePage.routeName:(context) => HomePage(),
        LoginScreen.routeName:(context) => LoginScreen(),
        Signup.routeName:(context) => Signup(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

