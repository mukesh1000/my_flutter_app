import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

final timelineRef = FirebaseFirestore.instance.collection('timeline');

class MyPost extends StatefulWidget {
  //final String documentID;
  //const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  
  @override
  void initState() {  
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 192, 67, 1),
        title: Text("Post Page"),
      ),

      body: StreamBuilder<QuerySnapshot> (
        stream: timelineRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final List<Text> children = snapshot.data!.docs.map((doc)
           => Text(doc['username'])).toList();
           return Container(
            child: ListView(
              children: children,
             ),

           );

        },
        ),

    );
  }
}



