//import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/Admin/Admin.dart';
import 'package:my_flutter_app/Admin/upload.dart';
import 'package:my_flutter_app/ChangePassowrd.dart';
import 'package:my_flutter_app/EditProfileScreen.dart';
import 'package:my_flutter_app/Homepage.dart';
import 'package:my_flutter_app/Login.dart';
import 'package:my_flutter_app/Post.dart';
import 'package:my_flutter_app/Profile_screen.dart';
import 'package:my_flutter_app/Search.dart';
import 'package:my_flutter_app/forgetpage.dart';
import 'package:my_flutter_app/Admin/AdminNavBar.dart';
import 'package:my_flutter_app/navigationbar/navbar.dart';
import 'package:my_flutter_app/register.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'Login',
    routes: {
      'Login':(context)=>MyLogin(),
      'register':(context)=>MyRegister(),
      'homepage':(context)=>MyHomepage(),
      'forgetpage':(context)=>Myforgetpassword(),
      'ProfileScreen':(context) => ProfileScreen(),
      'EditProfileScreen':(context) => EditProfileScreen(),
      'ChangePassword':(context) => ChangePassword(),
      'Admin':(context) => MyAdmin(),
      'Search':(context) => MySearch(),
      'Post':(context) => MyPost(),
      'Navbar':(context) => Navbar(),
      'AdminNavBar':(context) => AdminNavbar(),
      'upload':(context) => upload(),
    },
  );
  }
}

