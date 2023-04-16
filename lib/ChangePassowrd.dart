import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State <ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
    var oldPasswordController= TextEditingController();
    var newPasswordController= TextEditingController();

    var auth = FirebaseAuth.instance;
    var currentUser = FirebaseAuth.instance.currentUser;
    

    changePassword({email,oldpassword,newpassword}) async{

      var cred = EmailAuthProvider.credential(email: email, password: oldpassword);

      await currentUser?.reauthenticateWithCredential(cred).then((value){
        currentUser?.updatePassword(newpassword);

      }).catchError((error){
        print(error.toString());
      });

    }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        title: const Text ("Change Password"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(image:AssetImage('assests/heraldProfile.PNG'))),
                ),
              TextFormField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  isDense: true,
                  alignLabelWithHint: true,
                  labelText: "old Password",
                  hintText: "******",
                  border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  isDense: true,
                  alignLabelWithHint: true,
                  labelText: "New Password",
                  hintText: "******",
                  border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
              await changePassword(
                email: "gautammukesh200@gmail.com", 
                oldpassword:oldPasswordController.text, 
                newpassword:newPasswordController.text,
                
                );
              print("change Password Sucessfully");
                
            },
            style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(116, 192, 67, 1),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
            child: const Text (
              "Change Password",
              
            ),
            
             ),

          ]),
      ),


    );

  }
}

 