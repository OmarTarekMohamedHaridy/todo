import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/home.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/register/signup.dart';
import 'package:todo/tabs/home_tab.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login ";
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen',style: TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
                  color: provider.Mytheme == ThemeMode.light
                      ? Color(0xff060E1E)
                      : Color(0xffFFFFFF),
                ),
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Color(0xffFFFFFF),)
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                style: TextStyle(
                  color: provider.Mytheme == ThemeMode.light
                      ? Color(0xff060E1E)
                      : Color(0xffFFFFFF),
                ),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',labelStyle: TextStyle(color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Color(0xffFFFFFF),)
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  FirebaseFunctions.Login(
                      emailController.text, passwordController.text, onError: (error) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(error),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Ok"))
                        ],
                      ),
                    );
                  },onSuccess: () async {
provider.initUser();
 await Future.delayed(Duration(microseconds: 500));
                        Navigator.pushNamedAndRemoveUntil(context,HomePage.routeName,(route) => false,);});
                },
                child: const Text('LogIn'),
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
                    text: "You Don't Have An Account ??",
                    style: TextStyle(fontSize: 20,
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),),
                TextSpan(
                    text: "  Sign Up",
                    style: TextStyle(fontSize: 25, color:
                    Colors.indigo)),
              ])),
        ),
        onTap: () {
          Navigator.pushNamed(context, Signup.routeName);
        },
      ),
    );
  }
}
