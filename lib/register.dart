// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/Homepage.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  //final DatabaseService currentUser;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _departmentController = TextEditingController();
  final _nameController = TextEditingController();
  final _displayname = TextEditingController();
  final _photoUrl = TextEditingController();
  final _bio = TextEditingController();
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _departmentController.dispose();
    _nameController.dispose();
    _displayname.dispose();
    _photoUrl.dispose();
    _bio.dispose();
    super.dispose();
  }

  Future registerUserwithEmailandPassword(
      String Name, String Email, String Address, String Department) async {
    try {
      User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text))
          .user!;
      if (user != null) {
        //call our database service to update the user data
        await DatabaseService(uid: user.uid).updateUserData(_nameController.text, _emailController.text,
         _addressController.text, _departmentController.text, _displayname.text, _photoUrl.text, _bio.text );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    //String _email='', _password='';
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(116, 192, 67, 1),
          //image: DecorationImage(image: AssetImage('assests/register.png'))
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
          backgroundColor: Colors.lightGreen,
          elevation: 0,
        ),
          backgroundColor: Color.fromRGBO(116, 192, 67, 1),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left:35, top:20),
                child: Text(
                  'Create\nAccount',
                  style: TextStyle(color: Colors.white, fontSize: 21,fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 30,
                ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10,
                      right: 55,
                      left: 35),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _departmentController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Department',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 30,
                      // ),
                      // TextField(
                      //   decoration: InputDecoration(
                      //       fillColor: Colors.grey.shade100,
                      //       filled: true,
                      //       hintText: 'Student ID',
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10))),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),

                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 27, fontWeight: FontWeight.w700),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color.fromARGB(255, 17, 17, 17),
                            child: IconButton(
                              color: Colors.green,
                              onPressed: () {
                                registerUserwithEmailandPassword (_nameController.text, _emailController.text, _addressController.text, _departmentController.text);
                                // try {
                                //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                //     email: _email, 
                                //     password: _password );
                                //     Navigator.pushNamed(context, 'homepage');
                                // } on FirebaseAuthException catch (e) {
                                //   if (e.code == "weak-password") {
                                //     print('The password provided is too weak');
                                //   } else if (e.code == 'email-already-in-use'){
                                //     print('The account already exists for that email ');
                                //   }

                                // } catch (e) {
                                //   print(e);
                                // }

                              },
                              icon: Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
  
}

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  //refrence for our collections
  final CollectionReference userCollection = 
  FirebaseFirestore.instance.collection("users");

  final CollectionReference groupCollection = 
  FirebaseFirestore.instance.collection("groups");

  //updating the userdata
  Future updateUserData(String Name, String Email, String Address, String Department, String displayname,String photoUrl,String bio )async {
    return await userCollection.doc(uid).set({
      "Name" : Name,
      "Address": Address,
      "Department":Department,
      "Email": Email,
      "uid": uid,
      "displayname": displayname,
      "photoUrl": photoUrl,
      "bio": bio,
    });

  }
}
