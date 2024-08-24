import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/home.dart';
import 'package:todo/register/login.dart';
import 'package:todo/tabs/home_tab.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              TextField(
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'UserName',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ageController,
                obscureText: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
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
                },
                child: const Text('SignUp'),
              ),
            ],
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
                    style: TextStyle(fontSize: 20)),
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
