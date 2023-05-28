import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_me/commenwidget/elevatedbuttonwidget.dart';
import 'package:swipe_me/content.dart';
import 'package:swipe_me/views/loginpage.dart';

import '../commenwidget/appbarwidget.dart';
import '../commenwidget/mytextfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameconrl = TextEditingController();
  TextEditingController emailconrl = TextEditingController();
  TextEditingController passwordconrl = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
 

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
              MyTextFieldWidget(text: "Name", controller: nameconrl),
              size,
              MyTextFieldWidget(
                controller: emailconrl,
                text: 'Email',
              ),
              size,
              MyTextFieldWidget(text: "password", controller: passwordconrl),
              size,
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                    onTap: () {},
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
                        .createUserWithEmailAndPassword(
                            email: emailconrl.text,
                            password: passwordconrl.text)
                        .catchError((onError) {})
                        .then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  LoginPage()));
                    });
                  },
                  text: "SignUp",
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
                                builder: (context) => LoginPage()));
                      },
                      child: const Text("  Login", style: frgettext))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
