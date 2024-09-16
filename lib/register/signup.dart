import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/home.dart';
import 'package:todo/register/login.dart';
import 'package:todo/tabs/home_tab.dart';

import '../providers/my_provider.dart';

class Signup extends StatefulWidget {
  static const String routeName = "SingUp ";
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var userNameController = TextEditingController();

  var ageController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up',style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body:

      Padding(
        padding: const EdgeInsets.only(top:160.0,right: 18,left: 18),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextFormField(
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
             validator: (value) {
               if(value ==null || value.isEmpty){
                 return "please Enter Your Email" ;
               }
               final bool emailValid =
               RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                   .hasMatch(value);
               if(!emailValid){return "please enter valid e-mail" ;}
             },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                        ? Color(0xff060E1E)
                        : Color(0xffFFFFFF),)
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if(value ==null || value.isEmpty){
                        return "please Enter Your Password" ;
                      }
                      final bool regex =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value);
                      if(value.length < 8){
                        return " Must be at least 8 characters in length " ;
                      }
                        if (!regex) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                    },

                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Password',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                        ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),)
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
                    controller: phoneController,
                    validator: (value) {
                      if(value ==null || value.isEmpty){
                        return "please Enter Your Phone" ;
                      }
                      return null ;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                        ? Color(0xff060E1E)
                        : Color(0xffFFFFFF),)
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if(value ==null || value.isEmpty){
                        return "please Enter Your Name" ;
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'UserName',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                        ? Color(0xff060E1E)
                        : Color(0xffFFFFFF),)
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
                    validator: (value) {
                      if (int.parse(value!)<20){
                        return "you must be more than 20 yo" ;
                      }
                      if(value ==null || value.isEmpty){
                        return "please Enter Your Age" ;
                      }
                      return null ;
                    },
                    controller: ageController,
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Age',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                        ? Color(0xff060E1E)
                        : Color(0xffFFFFFF),)
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        FirebaseFunctions.CreateAccount(
                            emailController.text, passwordController.text,
                            phone: int.parse(phoneController.text),
                            age: int.parse(ageController.text),
                            username: userNameController.text,
                            onSuccess: () {

                              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(route) => false,);
                            }, onError: (message) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text(message),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {

                                      Navigator.pop(context);
                                    },
                                    child: Text("Ok"))
                              ],
                            ),
                          );
                        });
                      }

                    },
                    child: const Text('SignUp'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "I Have An Account ??",
                    style: TextStyle(fontSize: 20, color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Colors.cyanAccent,)),
                TextSpan(
                    text: " LogIn",
                    style: TextStyle(fontSize: 25, color: Colors.indigo)),
              ])),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
