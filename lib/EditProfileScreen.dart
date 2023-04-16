import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
        //   onPressed: () {
        //   Navigator.pushNamed(context, 'ProfileScreen');
        // },
        icon: const Icon(LineAwesomeIcons.angle_left, color: Colors.black,)),
        title: Text('EditProfile', style:Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Container( 
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(),
              const SizedBox(height: 30),
              Form(child: Column(
                children: [
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Full Name'), prefixIcon: Icon(LineAwesomeIcons.user)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('address'), prefixIcon: Icon(LineAwesomeIcons.address_book)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Department'), prefixIcon: Icon(LineAwesomeIcons.school)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Phone Number'), prefixIcon: Icon(LineAwesomeIcons.phone)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Starting Year'), prefixIcon: Icon(LineAwesomeIcons.calendar)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Graduation Year'), prefixIcon: Icon(LineAwesomeIcons.calendar_1)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Job Status'), prefixIcon: Icon(LineAwesomeIcons.desktop)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration:
                     const InputDecoration(label: Text('Email'), prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                  ),
                  SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'ProfileScreen');
                    },       
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(116, 192, 67, 1), side: BorderSide.none, shape: const StadiumBorder()),
                    child: const Text('EditProfile',style: TextStyle(color: Colors.black)),
              
                  ),
                ),

              ],))

          ],)
        ),
      ),
    );
  }
}