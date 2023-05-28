import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:swipe_me/content.dart';
import 'package:swipe_me/views/forgetpassword_view.dart';
import 'package:swipe_me/views/homepage.dart';
import 'package:swipe_me/views/signup_view.dart';

import '../commenwidget/appbarwidget.dart';
import '../commenwidget/elevatedbuttonwidget.dart';
import '../commenwidget/mytextfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Swipe Me',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SignUp", style: hdText),
              size,
              MyTextFieldWidget(
                controller: emailcontroller,
                text: 'Email',
              ),
              size,
              MyTextFieldWidget(
                  text: "password", controller: passwordcontroller),
              size,
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    },
                    child: const Text(
                      "Forget password",
                      style: frgettext,
                    )),
              ),
              size,
              Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue),
                child: MyElevatedButton(
                  onpress: () async {
                    await _auth
                        .signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text)
                        .catchError((onError) {})
                        .then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  text: "Login",
                ),
              ),
              size,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already you have an account ?",
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()));
                      },
                      child: const Text("  Signup", style: frgettext))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
