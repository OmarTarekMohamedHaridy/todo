import 'package:flutter/material.dart';

class Mytheme {

static ThemeData LightTheme =

ThemeData(
scaffoldBackgroundColor: Color(0xffFFFFFF),
    appBarTheme:  AppBarTheme(
  titleTextStyle: TextStyle(color:Color(0xff5D9CEC),),
    backgroundColor:Color(0xff5D9CEC),

),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: Color(0xffFFFFFF),
));




static ThemeData DarkTheme =
ThemeData(
    scaffoldBackgroundColor: Color(0xff060E1E),
    appBarTheme:  AppBarTheme(
  titleTextStyle: TextStyle(color:Color(0xffFFFFFF),),
  backgroundColor:Color(0xff5D9CEC),

),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff141922),
    ));
}