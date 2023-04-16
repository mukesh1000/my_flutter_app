//import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:my_flutter_app/EditProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        leading: IconButton(
            // onPressed: () => Navigator.of(context).pop(),
              onPressed: () {
                Navigator.pushNamed(context, 'Navbar');
              },
              
            icon: const Icon(
              LineAwesomeIcons.angle_left,
              color: Colors.black,
            )),
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                        image: AssetImage('assests/heraldProfile.PNG'))),
              ),
              Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromRGBO(116, 192, 67, 1), //.withOpacity(0.1),
                      ),
                  child: Icon(LineAwesomeIcons.alternate_pencil,
                      size: 18.0, color: Colors.black)),

              const SizedBox(height: 10),
              Text(
                'User',
                style: TextStyle(color: Colors.black),
              ),
              Text('user@gmail.com', style: TextStyle(color: Colors.black)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'EditProfileScreen');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(116, 192, 67, 1),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('EditProfile',
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //menu

              ProfileMenuWidget(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "History",
                  icon: LineAwesomeIcons.history,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Change Password",
                  icon: LineAwesomeIcons.lock,
                  onPress: () {
                    Navigator.pushNamed(context, 'ChangePassword');
                  }),
              ProfileMenuWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Navigator.pushNamed(context, 'Login');
                  }),
              ElevatedButton(
                onPressed: () {
                  void deleteUser() async {
                    User user = FirebaseAuth.instance.currentUser!;
                    await user.delete();
                    // Navigator.pushNamed(context, 'Login');
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text('Delete Account',
                    style: TextStyle(color: Colors.black)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(116, 192, 67, 1).withOpacity(0.1),
        ),
        child: Icon(icon, color: Color.fromRGBO(116, 192, 67, 1)),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyMedium?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue.withOpacity(0.1),
              ),
              child: Icon(LineAwesomeIcons.angle_right,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
