import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_me/commenwidget/elevatedbuttonwidget.dart';
import 'package:swipe_me/commenwidget/mytextfield.dart';
import 'package:swipe_me/content.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcolr.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Password reset link send ! check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  TextEditingController emailcolr = TextEditingController();
  @override
  void dispose() {
    emailcolr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                "Enter your email and we will send you a password reset link"),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextFieldWidget(text: "Email", controller: emailcolr)),
          size,
          MyElevatedButton(text: "Reset Password", onpress: passwordreset)
        ],
      ),
    );
  }
}
