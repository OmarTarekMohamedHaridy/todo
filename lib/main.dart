import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/home.dart';

void main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.RouteName,
      routes: {HomePage.RouteName:(context) => HomePage()},
      debugShowCheckedModeBanner: false,
    );
  }
}

