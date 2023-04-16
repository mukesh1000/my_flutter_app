// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Myforgetpassword extends StatefulWidget {
  const Myforgetpassword({super.key});

  @override
  State <Myforgetpassword> createState() => MyforgetpasswordState();
}

class MyforgetpasswordState extends State<Myforgetpassword> {
  final _email= TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }
  Future PasswordReset() async {
    try{
      await FirebaseAuth.instance.
    sendPasswordResetEmail(email: _email.text.trim());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Password Reset link send ! check your email '),
          );
          }, );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      }, );
    }


  }
  
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your Email and we will send you password reset link ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            ),
          
          Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,
                right: 35,
                left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
        ],
      )

          ),
          SizedBox(height: 20),
          MaterialButton(onPressed: PasswordReset,
          child: Text("Reset Password"),
          color:Color.fromRGBO(116, 192, 67, 1),
          ),
        ] //children
     
    )
    );
  
  }
}