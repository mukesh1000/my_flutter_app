// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Image.asset('assests/heraldProfile.PNG',
            // fit: BoxFit.contain, // Use BoxFit.cover to stretch the image to fill the screen
            // width: 180.0, // Set width to match the screen width
            // height: 180.0,
            // ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 370.0,
              left: MediaQuery.of(context).size.width / 2 - 80.0,
              child: Image.asset(
                'assests/heraldProfile.PNG', // Replace this with the actual path to your image
                fit: BoxFit.contain,
                width: 200.0,
                height: 200.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 90, top: 280),
              child: Text(
                'Welcome Graduates',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 60, top: 360),
              child: Text(
                'Welcome to yours own Alumnus app',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(116, 192, 67, 1)),
                              borderRadius: BorderRadius.circular(10))
                              ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(116, 192, 67, 1)),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'forgetpage');
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                                //decoration: TextDecoration.underline,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(116, 192, 67, 1)),
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color.fromRGBO(116, 192, 67, 1),
                          child: IconButton(
                            color: Colors.black,
                            onPressed: () async {
                              //                                 try {
                              //                                   if ( await FirebaseAuth.signInWithEmailAndPassword(
                              //   email: "admin@gmail.com",
                              //   password: "admin123",
                              // );) {

                              //                                     Navigator.pushNamed(
                              //                                         context, 'AdminNavBar');
                              //                                   }
                              //                                   UserCredential userCredential =
                              //                                       await FirebaseAuth.instance
                              //                                           .signInWithEmailAndPassword(
                              //                                               email: _emailController.text,
                              //                                               password:
                              //                                                   _passwordController.text);
                              //                                   Navigator.pushNamed(context, 'Navbar');
                              //                                 } on FirebaseAuthException catch (e) {
                              //                                   if (e.code == 'user-not-found') {
                              //                                     print('No user found for that email.');
                              //                                   } else if (e.code == 'wrong-password') {
                              //                                     print(
                              //                                         'Wrong password provided for that user.');
                              //                                   }
                              //                                 }
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (userCredential.user != null) {
                                  // Authentication successful
                                  if (_emailController.text ==
                                      "admin@gmail.com") {
                                    Navigator.pushNamed(context, 'AdminNavBar');
                                  } else {
                                    Navigator.pushNamed(context, 'Navbar');
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member? ',
                          style: TextStyle(
                            //decoration: TextDecoration.underline,
                            fontSize: 18,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                              //decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(116, 192, 67, 1),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //),
    );
  }
}
